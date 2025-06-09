import 'package:flutter/foundation.dart';

@immutable
class User {
  final String id;
  final String email;
  final String? password;
  final String name;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? emailVerified;
  final String? image;

  const User({
    required this.id,
    required this.email,
    this.password,
    required this.name,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.emailVerified,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      name: json['name'] as String,
      role: json['role'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      emailVerified: json['emailVerified'] != null ? DateTime.parse(json['emailVerified']) : null,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'emailVerified': emailVerified?.toIso8601String(),
      'image': image,
    };
  }
}
