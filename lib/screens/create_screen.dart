import 'package:flutter/material.dart';
import '/main.dart';
import '/models/recipe.dart';
import '/models/tag.dart';
import 'recipe_edit_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Create Recipe'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeEditScreen(
                    recipe: Recipe(name: '', prepTime: 0),
                    isNew: true,
                  ),
                ),
              ).then((newRecipe) {
                if (newRecipe != null) {
                  setStateGlobal(() {
                    recipes.add(newRecipe.copyWith(id: nextRecipeId++));
                  });
                }
              }),
            ),
            ElevatedButton(
              child: Text('Create Tag'),
              onPressed: () => _showCreateTagDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateTagDialog(BuildContext context) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Tag'),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setStateGlobal(() {
                    tags.add(Tag(id: nextTagId++, name: controller.text));
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}