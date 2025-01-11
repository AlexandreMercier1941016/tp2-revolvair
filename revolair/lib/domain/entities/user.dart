class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'].toString(),
      email: json['email'].toString(),
      password: json['password'].toString(),
    );
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, password: $password}';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is User &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            email == other.email &&
            password == other.password;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ password.hashCode;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }

  factory User.empty() {
    return User(name: '', email: '', password: '');
  }
}