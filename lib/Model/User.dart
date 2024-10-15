enum UserRole { Counsellor, Faculty }

class User {
  String id;
  String name;
  UserRole role;

  User({
    required this.id,
    required this.name,
    required this.role,
  });
}