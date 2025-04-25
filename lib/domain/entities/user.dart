class User {
  final String email;
  final String name;
  final String password;

  User({required this.email, required this.name, required this.password});

  Map<String, String> toMap() => {
        'email': email,
        'name': name,
        'password': password,
      };

  factory User.fromMap(Map<String, dynamic> map) => User(
        email: map['email'] as String,
        name: map['name'] as String,
        password: map['password'] as String,
      );
}
