class Recipe {
  int? id;
  String name;
  int prepTime;
  List<String> tags;
  List<String> ingredients;
  List<String> steps;

  Recipe({
    this.id,
    required this.name,
    required this.prepTime,
    this.tags = const [],
    this.ingredients = const [],
    this.steps = const [],
  });

  Recipe copyWith({
    int? id,
    String? name,
    int? prepTime,
    List<String>? tags,
    List<String>? ingredients,
    List<String>? steps,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      prepTime: prepTime ?? this.prepTime,
      tags: tags ?? this.tags,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
    );
  }
}