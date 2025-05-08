import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeEditScreen extends StatefulWidget {
  final Recipe recipe;
  final bool isNew;

  const RecipeEditScreen({Key? key, required this.recipe, this.isNew = false})
    : super(key: key);

  @override
  _RecipeEditScreenState createState() => _RecipeEditScreenState();
}

class _RecipeEditScreenState extends State<RecipeEditScreen> {
  late Recipe editedRecipe;
  final _nameController = TextEditingController();
  final _prepTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    editedRecipe = widget.recipe.copyWith();
    _nameController.text = editedRecipe.name;
    _prepTimeController.text = editedRecipe.prepTime.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _prepTimeController.dispose();
    super.dispose();
  }

  Future<void> _showAddIngredientDialog() async {
    final nameController = TextEditingController();
    final quantityController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Ingredient'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Ingredient Name'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    editedRecipe = editedRecipe.copyWith(
                      ingredients: [
                        ...editedRecipe.ingredients,
                        '${quantityController.text} ${nameController.text}',
                      ],
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddStepDialog() async {
    final stepController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Step'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: stepController,
              decoration: InputDecoration(labelText: 'Step Description'),
              maxLines: 3,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    editedRecipe = editedRecipe.copyWith(
                      steps: [...editedRecipe.steps, stepController.text],
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNew ? 'Add Recipe' : 'Edit Recipe'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              editedRecipe = editedRecipe.copyWith(
                name: _nameController.text,
                prepTime: int.tryParse(_prepTimeController.text) ?? 0,
              );
              Navigator.pop(context, editedRecipe);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Recipe Name'),
            ),
            TextField(
              controller: _prepTimeController,
              decoration: InputDecoration(labelText: 'Prep Time (minutes)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Ingredients',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _showAddIngredientDialog,
                ),
              ],
            ),
            ...editedRecipe.ingredients
                .map(
                  (ing) => ListTile(
                    title: Text(ing),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed:
                          () => setState(() {
                            editedRecipe = editedRecipe.copyWith(
                              ingredients:
                                  editedRecipe.ingredients
                                      .where((i) => i != ing)
                                      .toList(),
                            );
                          }),
                    ),
                  ),
                )
                .toList(),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Steps', style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _showAddStepDialog,
                ),
              ],
            ),
            ...editedRecipe.steps
                .asMap()
                .entries
                .map(
                  (entry) => ListTile(
                    title: Text('${entry.key + 1}. ${entry.value}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed:
                          () => setState(() {
                            final newSteps = List<String>.from(
                              editedRecipe.steps,
                            );
                            newSteps.removeAt(entry.key);
                            editedRecipe = editedRecipe.copyWith(
                              steps: newSteps,
                            );
                          }),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
