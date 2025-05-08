import 'package:flutter/material.dart';
import 'models/recipe.dart';
import 'models/tag.dart';
import 'screens/browse_screen.dart';
import 'screens/create_screen.dart';
import 'screens/tags_screen.dart';

// Global in-memory data
List<Recipe> recipes = [];
List<Tag> tags = [];
int nextRecipeId = 1;
int nextTagId = 1;

void main() {
  // Add sample data
  tags.add(Tag(id: nextTagId++, name: "Vegetarian"));
  tags.add(Tag(id: nextTagId++, name: "Quick"));
  tags.add(Tag(id: nextTagId++, name: "Dinner"));
  
  recipes.add(Recipe(
    id: nextRecipeId++,
    name: "Spaghetti",
    prepTime: 15,
    tags: ["Quick", "Dinner"],
    ingredients: ["200g pasta", "1 jar sauce"],
    steps: ["Boil water", "Cook pasta", "Heat sauce", "Combine"],
  ));

  runApp(RecipeApp());
}

// Helper function to update state globally
void setStateGlobal(VoidCallback fn) {
  fn();
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => BrowseScreen()),
              ),
              child: Text('Browse'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => CreateScreen()),
              ),
              child: Text('Create'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => TagsScreen()),
              ),
              child: Text('My Tags'),
            ),
          ],
        ),
      ),
    );
  }
}