class Tag {
  int? id;
  String name;

  Tag({this.id, required this.name});

  Tag copyWith({int? id, String? name}) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}