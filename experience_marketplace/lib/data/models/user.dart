import 'package:flutter/foundation.dart';

@immutable
class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String? bio;
  final bool isHost;
  final DateTime joinDate;
  final List<String> favoriteExperienceIds;
  final double? rating;
  final int? totalReviews;
  final String? phoneNumber;
  final Map<String, dynamic>? preferences;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.bio,
    this.isHost = false,
    required this.joinDate,
    this.favoriteExperienceIds = const [],
    this.rating,
    this.totalReviews,
    this.phoneNumber,
    this.preferences,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? bio,
    bool? isHost,
    DateTime? joinDate,
    List<String>? favoriteExperienceIds,
    double? rating,
    int? totalReviews,
    String? phoneNumber,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      isHost: isHost ?? this.isHost,
      joinDate: joinDate ?? this.joinDate,
      favoriteExperienceIds:
          favoriteExperienceIds ?? this.favoriteExperienceIds,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      preferences: preferences ?? this.preferences,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'bio': bio,
      'isHost': isHost,
      'joinDate': joinDate.toIso8601String(),
      'favoriteExperienceIds': favoriteExperienceIds,
      'rating': rating,
      'totalReviews': totalReviews,
      'phoneNumber': phoneNumber,
      'preferences': preferences,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      isHost: json['isHost'] as bool? ?? false,
      joinDate: DateTime.parse(json['joinDate'] as String),
      favoriteExperienceIds:
          (json['favoriteExperienceIds'] as List<dynamic>?)?.cast<String>() ??
              const [],
      rating: (json['rating'] as num?)?.toDouble(),
      totalReviews: json['totalReviews'] as int?,
      phoneNumber: json['phoneNumber'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>?,
    );
  }
}
