class AppUser {
  final String id;
  final String? name;
  final String email;

  const AppUser({required this.id, required this.email, this.name});

  factory AppUser.fromFireStore(Map<String, dynamic> data, String id) {
    return AppUser(id: id, email: data["email"], name: data["name"]);
  }

  Map<String, dynamic> toFireStore() {
    return {"email": email, "name": name};
  }
}
