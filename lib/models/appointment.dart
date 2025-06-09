import 'package:flutter/foundation.dart';

@immutable
class Appointment {
  final int id;
  final String patientId;
  final String doctorId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String status;
  final String? reason;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.reason,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as int,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: json['status'] as String,
      reason: json['reason'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'reason': reason,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
