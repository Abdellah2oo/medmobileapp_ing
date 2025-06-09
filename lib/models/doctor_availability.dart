import 'package:flutter/foundation.dart';

@immutable
class DoctorAvailability {
  final int id;
  final int doctorId;
  final int dayOfWeek;
  final String startTime;
  final String endTime;

  const DoctorAvailability({
    required this.id,
    required this.doctorId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorAvailability.fromJson(Map<String, dynamic> json) {
    return DoctorAvailability(
      id: json['id'] as int,
      doctorId: json['doctorId'] as int,
      dayOfWeek: json['dayOfWeek'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
