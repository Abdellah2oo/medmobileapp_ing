import 'package:flutter/foundation.dart';

@immutable
class DoctorFull {
  final int id;
  final String userId;
  final String specialization;
  final String qualifications;
  final int experience;
  final String licenseNumber;
  final String? bio;
  final double consultationFee;

  const DoctorFull({
    required this.id,
    required this.userId,
    required this.specialization,
    required this.qualifications,
    required this.experience,
    required this.licenseNumber,
    this.bio,
    required this.consultationFee,
  });

  factory DoctorFull.fromJson(Map<String, dynamic> json) {
    return DoctorFull(
      id: json['id'] as int,
      userId: json['userId'] as String,
      specialization: json['specialization'] as String,
      qualifications: json['qualifications'] as String,
      experience: json['experience'] as int,
      licenseNumber: json['licenseNumber'] as String,
      bio: json['bio'] as String?,
      consultationFee: (json['consultationFee'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'specialization': specialization,
      'qualifications': qualifications,
      'experience': experience,
      'licenseNumber': licenseNumber,
      'bio': bio,
      'consultationFee': consultationFee,
    };
  }
}
