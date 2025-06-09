import 'package:flutter/foundation.dart';

@immutable
class Patient {
  final int id;
  final String userId;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? bloodType;
  final String? allergies;
  final String? medicalHistory;

  const Patient({
    required this.id,
    required this.userId,
    this.dateOfBirth,
    this.gender,
    this.bloodType,
    this.allergies,
    this.medicalHistory,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as int,
      userId: json['userId'] as String,
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      gender: json['gender'] as String?,
      bloodType: json['bloodType'] as String?,
      allergies: json['allergies'] as String?,
      medicalHistory: json['medicalHistory'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'bloodType': bloodType,
      'allergies': allergies,
      'medicalHistory': medicalHistory,
    };
  }
}
