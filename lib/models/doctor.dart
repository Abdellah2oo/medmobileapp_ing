import 'package:flutter/foundation.dart';

@immutable
class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String imageUrl;
  final String experience;
  final String schedule;

  const Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.experience,
    required this.schedule,
  });

  // Factory constructor for JSON deserialization
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      imageUrl: json['imageUrl'] as String,
      experience: json['experience'] as String,
      schedule: json['schedule'] as String,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specialty': specialty,
      'rating': rating,
      'reviews': reviews,
      'imageUrl': imageUrl,
      'experience': experience,
      'schedule': schedule,
    };
  }
}
