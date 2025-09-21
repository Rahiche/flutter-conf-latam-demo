/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../model/user.dart' as _i2;
import '../model/review.dart' as _i3;
import '../model/category.dart' as _i4;

abstract class Experience implements _i1.SerializableModel {
  Experience._({
    this.id,
    required this.name,
    required this.location,
    this.photoUrl,
    required this.startsAt,
    required this.endsAt,
    this.attendees,
    this.reviews,
    required this.categoryId,
    this.category,
  });

  factory Experience({
    int? id,
    required String name,
    required String location,
    String? photoUrl,
    required DateTime startsAt,
    required DateTime endsAt,
    List<_i2.User>? attendees,
    List<_i3.Review>? reviews,
    required int categoryId,
    _i4.Category? category,
  }) = _ExperienceImpl;

  factory Experience.fromJson(Map<String, dynamic> jsonSerialization) {
    return Experience(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      location: jsonSerialization['location'] as String,
      photoUrl: jsonSerialization['photoUrl'] as String?,
      startsAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startsAt']),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      attendees: (jsonSerialization['attendees'] as List?)
          ?.map((e) => _i2.User.fromJson((e as Map<String, dynamic>)))
          .toList(),
      reviews: (jsonSerialization['reviews'] as List?)
          ?.map((e) => _i3.Review.fromJson((e as Map<String, dynamic>)))
          .toList(),
      categoryId: jsonSerialization['categoryId'] as int,
      category: jsonSerialization['category'] == null
          ? null
          : _i4.Category.fromJson(
              (jsonSerialization['category'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String location;

  String? photoUrl;

  DateTime startsAt;

  DateTime endsAt;

  List<_i2.User>? attendees;

  List<_i3.Review>? reviews;

  int categoryId;

  _i4.Category? category;

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Experience copyWith({
    int? id,
    String? name,
    String? location,
    String? photoUrl,
    DateTime? startsAt,
    DateTime? endsAt,
    List<_i2.User>? attendees,
    List<_i3.Review>? reviews,
    int? categoryId,
    _i4.Category? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'location': location,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      if (attendees != null)
        'attendees': attendees?.toJson(valueToJson: (v) => v.toJson()),
      if (reviews != null)
        'reviews': reviews?.toJson(valueToJson: (v) => v.toJson()),
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExperienceImpl extends Experience {
  _ExperienceImpl({
    int? id,
    required String name,
    required String location,
    String? photoUrl,
    required DateTime startsAt,
    required DateTime endsAt,
    List<_i2.User>? attendees,
    List<_i3.Review>? reviews,
    required int categoryId,
    _i4.Category? category,
  }) : super._(
          id: id,
          name: name,
          location: location,
          photoUrl: photoUrl,
          startsAt: startsAt,
          endsAt: endsAt,
          attendees: attendees,
          reviews: reviews,
          categoryId: categoryId,
          category: category,
        );

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Experience copyWith({
    Object? id = _Undefined,
    String? name,
    String? location,
    Object? photoUrl = _Undefined,
    DateTime? startsAt,
    DateTime? endsAt,
    Object? attendees = _Undefined,
    Object? reviews = _Undefined,
    int? categoryId,
    Object? category = _Undefined,
  }) {
    return Experience(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      photoUrl: photoUrl is String? ? photoUrl : this.photoUrl,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      attendees: attendees is List<_i2.User>?
          ? attendees
          : this.attendees?.map((e0) => e0.copyWith()).toList(),
      reviews: reviews is List<_i3.Review>?
          ? reviews
          : this.reviews?.map((e0) => e0.copyWith()).toList(),
      categoryId: categoryId ?? this.categoryId,
      category:
          category is _i4.Category? ? category : this.category?.copyWith(),
    );
  }
}
