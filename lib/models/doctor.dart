
import 'package:flutter/foundation.dart';

@immutable
class Doctor {
  final String name;
  final String sex;
  final String specialty;
  final double rating;
  final int reviews;
  final String imageUrl;
  final String experience;
  final String schedule;
  final bool isFavorite;

  const Doctor({
    required this.name,
    required this.sex,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.experience,
    required this.schedule,
    this.isFavorite = false,
  });

  Doctor copyWith({
    bool? isFavorite,
  }) {
    return Doctor(
      name: name,
      sex: sex,
      specialty: specialty,
      rating: rating,
      reviews: reviews,
      imageUrl: imageUrl,
      experience: experience,
      schedule: schedule,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Factory constructor for JSON deserialization
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'] as String,
      sex: json['sex'] as String,
      specialty: json['specialty'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      imageUrl: json['imageUrl'] as String,
      experience: json['experience'] as String,
      schedule: json['schedule'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sex': sex,
      'specialty': specialty,
      'rating': rating,
      'reviews': reviews,
      'imageUrl': imageUrl,
      'experience': experience,
      'schedule': schedule,
      'isFavorite': isFavorite,
    };
  }
}
