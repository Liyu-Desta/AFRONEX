class User {
  final String username;
  final String email;
  final String birthDate;
  final String password;

  User({
    required this.username,
    required this.email,
    required this.birthDate,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      birthDate: json['birthDate'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'birthDate': birthDate,
      'password': password,
    };
  }
}
