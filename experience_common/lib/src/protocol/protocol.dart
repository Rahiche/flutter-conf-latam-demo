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
import 'model/category.dart' as _i2;
import 'model/experience.dart' as _i3;
import 'model/review.dart' as _i4;
import 'model/user.dart' as _i5;
import 'package:experience_common/src/protocol/model/category.dart' as _i6;
import 'package:experience_common/src/protocol/model/experience.dart' as _i7;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i8;
export 'model/category.dart';
export 'model/experience.dart';
export 'model/review.dart';
export 'model/user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Category) {
      return _i2.Category.fromJson(data) as T;
    }
    if (t == _i3.Experience) {
      return _i3.Experience.fromJson(data) as T;
    }
    if (t == _i4.Review) {
      return _i4.Review.fromJson(data) as T;
    }
    if (t == _i5.User) {
      return _i5.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Category?>()) {
      return (data != null ? _i2.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Experience?>()) {
      return (data != null ? _i3.Experience.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Review?>()) {
      return (data != null ? _i4.Review.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.User?>()) {
      return (data != null ? _i5.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i5.User>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i5.User>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.Review>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i4.Review>(e)).toList()
          : null) as T;
    }
    if (t == List<_i6.Category>) {
      return (data as List).map((e) => deserialize<_i6.Category>(e)).toList()
          as T;
    }
    if (t == List<_i7.Experience>) {
      return (data as List).map((e) => deserialize<_i7.Experience>(e)).toList()
          as T;
    }
    try {
      return _i8.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    switch (data) {
      case _i2.Category():
        return 'Category';
      case _i3.Experience():
        return 'Experience';
      case _i4.Review():
        return 'Review';
      case _i5.User():
        return 'User';
    }
    className = _i8.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i2.Category>(data['data']);
    }
    if (dataClassName == 'Experience') {
      return deserialize<_i3.Experience>(data['data']);
    }
    if (dataClassName == 'Review') {
      return deserialize<_i4.Review>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i5.User>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i8.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
