import 'dart:convert';

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        id: parsedJson['id'],
        username: parsedJson['username'],
        firstName: parsedJson['first_name'],
        lastName: parsedJson['last_name'],
        email: parsedJson['email']);
  }
}
