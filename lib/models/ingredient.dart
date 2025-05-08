class Ingredient {
  int? id;
  int recipeId;
  String name;
  String quantity;

  Ingredient({
    this.id,
    required this.recipeId,
    required this.name,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipeId': recipeId,
      'name': name,
      'quantity': quantity,
    };
  }

  static Ingredient fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      recipeId: map['recipeId'],
      name: map['name'],
      quantity: map['quantity'],
    );
  }
}