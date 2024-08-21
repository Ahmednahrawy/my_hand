enum Role {
  owner,
  empolyee,
}

class User {
  final String name;
  final String email;
  final Role role; 

  User({
    required this.name,
    required this.email,
    required this.role,
  });
}
