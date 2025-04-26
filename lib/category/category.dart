final class Category {
  final String? id;
  final String? name;
  final String? description;

  const Category({this.id, this.name, this.description});

  static Category fromFireStore(String id, Map<String, dynamic> data) {
    return Category(
      id: id,
      name: data["name"],
      description: data["description"],
    );
  }
}
