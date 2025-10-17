class User {
  final int id;
  final String name;
  final String email;
  final List<int> allowedBrandIds;

  User({
    required this.id,
    required this.name,
    required this.email,
    List<int>? allowedBrandIds,
  }) : allowedBrandIds = allowedBrandIds ?? [];

  User copyWith({
    int? id,
    String? name,
    String? email,
    List<int>? allowedBrandIds,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      allowedBrandIds: allowedBrandIds ?? this.allowedBrandIds,
    );
  }
}

