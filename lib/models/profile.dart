import 'package:flutter/foundation.dart';

@immutable
class Profile {
  final int id;
  final String userId;
  final String? phoneNumber;
  final String? address;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? avatar;

  const Profile({
    required this.id,
    required this.userId,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int,
      userId: json['userId'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'avatar': avatar,
    };
  }
}
