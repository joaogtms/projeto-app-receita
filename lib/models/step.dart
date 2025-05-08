class Step {
  int? id;
  int recipeId;
  int order;
  String description;

  Step({
    this.id,
    required this.recipeId,
    required this.order,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipeId': recipeId,
      'order': order,
      'description': description,
    };
  }

  static Step fromMap(Map<String, dynamic> map) {
    return Step(
      id: map['id'],
      recipeId: map['recipeId'],
      order: map['order'],
      description: map['description'],
    );
  }
}