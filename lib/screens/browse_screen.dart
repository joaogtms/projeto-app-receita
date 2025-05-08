import 'package:flutter/material.dart';
import 'package:projeto_app/main.dart';
import '/models/recipe.dart';
import 'recipe_detail_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<Recipe> filteredRecipes = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes;
  }

  void _applyFilters() {
    setState(() {
      filteredRecipes = recipes.where((recipe) {
        return recipe.name.toLowerCase().contains(searchQuery.toLowerCase()) || 
               searchQuery.isEmpty;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Browse Recipes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                searchQuery = value;
                _applyFilters();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return ListTile(
                  title: Text(recipe.name),
                  subtitle: Text('${recipe.tags.join(", ")} • ${recipe.prepTime} min'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(recipe: recipe),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}