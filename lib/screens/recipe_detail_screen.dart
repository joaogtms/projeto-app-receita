import 'package:flutter/material.dart';
import 'package:projeto_app/main.dart';
import '../models/recipe.dart';
import 'recipe_edit_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Tags: ${recipe.tags.join(", ")}'),
            SizedBox(height: 20),
            Text('Preparation Time: ${recipe.prepTime} minutes'),
            SizedBox(height: 20),
            Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...recipe.ingredients.map((ing) => Text('- $ing')).toList(),
            SizedBox(height: 20),
            Text('Steps:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...recipe.steps.asMap().entries.map((entry) => 
              Text('${entry.key + 1}. ${entry.value}')).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeEditScreen(recipe: recipe),
          ),
        ).then((updatedRecipe) {
          if (updatedRecipe != null) {
            setStateGlobal(() {
              final index = recipes.indexWhere((r) => r.id == updatedRecipe.id);
              if (index != -1) {
                recipes[index] = updatedRecipe;
              }
            });
          }
        }),
      ),
    );
  }
}