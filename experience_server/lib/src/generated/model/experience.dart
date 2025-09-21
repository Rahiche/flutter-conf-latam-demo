/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../model/user.dart' as _i2;
import '../model/review.dart' as _i3;
import '../model/category.dart' as _i4;

abstract class Experience
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ExperienceTable();

  static const db = ExperienceRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'location': location,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      if (attendees != null)
        'attendees':
            attendees?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (reviews != null)
        'reviews': reviews?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJsonForProtocol(),
    };
  }

  static ExperienceInclude include({
    _i2.UserIncludeList? attendees,
    _i3.ReviewIncludeList? reviews,
    _i4.CategoryInclude? category,
  }) {
    return ExperienceInclude._(
      attendees: attendees,
      reviews: reviews,
      category: category,
    );
  }

  static ExperienceIncludeList includeList({
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExperienceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExperienceTable>? orderByList,
    ExperienceInclude? include,
  }) {
    return ExperienceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Experience.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Experience.t),
      include: include,
    );
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

class ExperienceTable extends _i1.Table<int?> {
  ExperienceTable({super.tableRelation}) : super(tableName: 'experience') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    location = _i1.ColumnString(
      'location',
      this,
    );
    photoUrl = _i1.ColumnString(
      'photoUrl',
      this,
    );
    startsAt = _i1.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _i1.ColumnDateTime(
      'endsAt',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString location;

  late final _i1.ColumnString photoUrl;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  _i2.UserTable? ___attendees;

  _i1.ManyRelation<_i2.UserTable>? _attendees;

  _i3.ReviewTable? ___reviews;

  _i1.ManyRelation<_i3.ReviewTable>? _reviews;

  late final _i1.ColumnInt categoryId;

  _i4.CategoryTable? _category;

  _i2.UserTable get __attendees {
    if (___attendees != null) return ___attendees!;
    ___attendees = _i1.createRelationTable(
      relationFieldName: '__attendees',
      field: Experience.t.id,
      foreignField: _i2.User.t.$_experienceAttendeesExperienceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    return ___attendees!;
  }

  _i3.ReviewTable get __reviews {
    if (___reviews != null) return ___reviews!;
    ___reviews = _i1.createRelationTable(
      relationFieldName: '__reviews',
      field: Experience.t.id,
      foreignField: _i3.Review.t.$_experienceReviewsExperienceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ReviewTable(tableRelation: foreignTableRelation),
    );
    return ___reviews!;
  }

  _i4.CategoryTable get category {
    if (_category != null) return _category!;
    _category = _i1.createRelationTable(
      relationFieldName: 'category',
      field: Experience.t.categoryId,
      foreignField: _i4.Category.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.CategoryTable(tableRelation: foreignTableRelation),
    );
    return _category!;
  }

  _i1.ManyRelation<_i2.UserTable> get attendees {
    if (_attendees != null) return _attendees!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'attendees',
      field: Experience.t.id,
      foreignField: _i2.User.t.$_experienceAttendeesExperienceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    _attendees = _i1.ManyRelation<_i2.UserTable>(
      tableWithRelations: relationTable,
      table: _i2.UserTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _attendees!;
  }

  _i1.ManyRelation<_i3.ReviewTable> get reviews {
    if (_reviews != null) return _reviews!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'reviews',
      field: Experience.t.id,
      foreignField: _i3.Review.t.$_experienceReviewsExperienceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ReviewTable(tableRelation: foreignTableRelation),
    );
    _reviews = _i1.ManyRelation<_i3.ReviewTable>(
      tableWithRelations: relationTable,
      table: _i3.ReviewTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _reviews!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        location,
        photoUrl,
        startsAt,
        endsAt,
        categoryId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'attendees') {
      return __attendees;
    }
    if (relationField == 'reviews') {
      return __reviews;
    }
    if (relationField == 'category') {
      return category;
    }
    return null;
  }
}

class ExperienceInclude extends _i1.IncludeObject {
  ExperienceInclude._({
    _i2.UserIncludeList? attendees,
    _i3.ReviewIncludeList? reviews,
    _i4.CategoryInclude? category,
  }) {
    _attendees = attendees;
    _reviews = reviews;
    _category = category;
  }

  _i2.UserIncludeList? _attendees;

  _i3.ReviewIncludeList? _reviews;

  _i4.CategoryInclude? _category;

  @override
  Map<String, _i1.Include?> get includes => {
        'attendees': _attendees,
        'reviews': _reviews,
        'category': _category,
      };

  @override
  _i1.Table<int?> get table => Experience.t;
}

class ExperienceIncludeList extends _i1.IncludeList {
  ExperienceIncludeList._({
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Experience.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Experience.t;
}

class ExperienceRepository {
  const ExperienceRepository._();

  final attach = const ExperienceAttachRepository._();

  final attachRow = const ExperienceAttachRowRepository._();

  final detach = const ExperienceDetachRepository._();

  final detachRow = const ExperienceDetachRowRepository._();

  /// Returns a list of [Experience]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Experience>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExperienceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExperienceTable>? orderByList,
    _i1.Transaction? transaction,
    ExperienceInclude? include,
  }) async {
    return session.db.find<Experience>(
      where: where?.call(Experience.t),
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Experience] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Experience?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExperienceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExperienceTable>? orderByList,
    _i1.Transaction? transaction,
    ExperienceInclude? include,
  }) async {
    return session.db.findFirstRow<Experience>(
      where: where?.call(Experience.t),
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Experience] by its [id] or null if no such row exists.
  Future<Experience?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ExperienceInclude? include,
  }) async {
    return session.db.findById<Experience>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Experience]s in the list and returns the inserted rows.
  ///
  /// The returned [Experience]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Experience>> insert(
    _i1.Session session,
    List<Experience> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Experience>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Experience] and returns the inserted row.
  ///
  /// The returned [Experience] will have its `id` field set.
  Future<Experience> insertRow(
    _i1.Session session,
    Experience row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Experience>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Experience]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Experience>> update(
    _i1.Session session,
    List<Experience> rows, {
    _i1.ColumnSelections<ExperienceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Experience>(
      rows,
      columns: columns?.call(Experience.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Experience]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Experience> updateRow(
    _i1.Session session,
    Experience row, {
    _i1.ColumnSelections<ExperienceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Experience>(
      row,
      columns: columns?.call(Experience.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Experience]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Experience>> delete(
    _i1.Session session,
    List<Experience> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Experience>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Experience].
  Future<Experience> deleteRow(
    _i1.Session session,
    Experience row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Experience>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Experience>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ExperienceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Experience>(
      where: where(Experience.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Experience>(
      where: where?.call(Experience.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ExperienceAttachRepository {
  const ExperienceAttachRepository._();

  /// Creates a relation between this [Experience] and the given [User]s
  /// by setting each [User]'s foreign key `_experienceAttendeesExperienceId` to refer to this [Experience].
  Future<void> attendees(
    _i1.Session session,
    Experience experience,
    List<_i2.User> user, {
    _i1.Transaction? transaction,
  }) async {
    if (user.any((e) => e.id == null)) {
      throw ArgumentError.notNull('user.id');
    }
    if (experience.id == null) {
      throw ArgumentError.notNull('experience.id');
    }

    var $user = user
        .map((e) => _i2.UserImplicit(
              e,
              $_experienceAttendeesExperienceId: experience.id,
            ))
        .toList();
    await session.db.update<_i2.User>(
      $user,
      columns: [_i2.User.t.$_experienceAttendeesExperienceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Experience] and the given [Review]s
  /// by setting each [Review]'s foreign key `_experienceReviewsExperienceId` to refer to this [Experience].
  Future<void> reviews(
    _i1.Session session,
    Experience experience,
    List<_i3.Review> review, {
    _i1.Transaction? transaction,
  }) async {
    if (review.any((e) => e.id == null)) {
      throw ArgumentError.notNull('review.id');
    }
    if (experience.id == null) {
      throw ArgumentError.notNull('experience.id');
    }

    var $review = review
        .map((e) => _i3.ReviewImplicit(
              e,
              $_experienceReviewsExperienceId: experience.id,
            ))
        .toList();
    await session.db.update<_i3.Review>(
      $review,
      columns: [_i3.Review.t.$_experienceReviewsExperienceId],
      transaction: transaction,
    );
  }
}

class ExperienceAttachRowRepository {
  const ExperienceAttachRowRepository._();

  /// Creates a relation between the given [Experience] and [Category]
  /// by setting the [Experience]'s foreign key `categoryId` to refer to the [Category].
  Future<void> category(
    _i1.Session session,
    Experience experience,
    _i4.Category category, {
    _i1.Transaction? transaction,
  }) async {
    if (experience.id == null) {
      throw ArgumentError.notNull('experience.id');
    }
    if (category.id == null) {
      throw ArgumentError.notNull('category.id');
    }

    var $experience = experience.copyWith(categoryId: category.id);
    await session.db.updateRow<Experience>(
      $experience,
      columns: [Experience.t.categoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Experience] and the given [User]
  /// by setting the [User]'s foreign key `_experienceAttendeesExperienceId` to refer to this [Experience].
  Future<void> attendees(
    _i1.Session session,
    Experience experience,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }
    if (experience.id == null) {
      throw ArgumentError.notNull('experience.id');
    }

    var $user = _i2.UserImplicit(
      user,
      $_experienceAttendeesExperienceId: experience.id,
    );
    await session.db.updateRow<_i2.User>(
      $user,
      columns: [_i2.User.t.$_experienceAttendeesExperienceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Experience] and the given [Review]
  /// by setting the [Review]'s foreign key `_experienceReviewsExperienceId` to refer to this [Experience].
  Future<void> reviews(
    _i1.Session session,
    Experience experience,
    _i3.Review review, {
    _i1.Transaction? transaction,
  }) async {
    if (review.id == null) {
      throw ArgumentError.notNull('review.id');
    }
    if (experience.id == null) {
      throw ArgumentError.notNull('experience.id');
    }

    var $review = _i3.ReviewImplicit(
      review,
      $_experienceReviewsExperienceId: experience.id,
    );
    await session.db.updateRow<_i3.Review>(
      $review,
      columns: [_i3.Review.t.$_experienceReviewsExperienceId],
      transaction: transaction,
    );
  }
}

class ExperienceDetachRepository {
  const ExperienceDetachRepository._();

  /// Detaches the relation between this [Experience] and the given [User]
  /// by setting the [User]'s foreign key `_experienceAttendeesExperienceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> attendees(
    _i1.Session session,
    List<_i2.User> user, {
    _i1.Transaction? transaction,
  }) async {
    if (user.any((e) => e.id == null)) {
      throw ArgumentError.notNull('user.id');
    }

    var $user = user
        .map((e) => _i2.UserImplicit(
              e,
              $_experienceAttendeesExperienceId: null,
            ))
        .toList();
    await session.db.update<_i2.User>(
      $user,
      columns: [_i2.User.t.$_experienceAttendeesExperienceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Experience] and the given [Review]
  /// by setting the [Review]'s foreign key `_experienceReviewsExperienceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> reviews(
    _i1.Session session,
    List<_i3.Review> review, {
    _i1.Transaction? transaction,
  }) async {
    if (review.any((e) => e.id == null)) {
      throw ArgumentError.notNull('review.id');
    }

    var $review = review
        .map((e) => _i3.ReviewImplicit(
              e,
              $_experienceReviewsExperienceId: null,
            ))
        .toList();
    await session.db.update<_i3.Review>(
      $review,
      columns: [_i3.Review.t.$_experienceReviewsExperienceId],
      transaction: transaction,
    );
  }
}

class ExperienceDetachRowRepository {
  const ExperienceDetachRowRepository._();

  /// Detaches the relation between this [Experience] and the given [User]
  /// by setting the [User]'s foreign key `_experienceAttendeesExperienceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> attendees(
    _i1.Session session,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $user = _i2.UserImplicit(
      user,
      $_experienceAttendeesExperienceId: null,
    );
    await session.db.updateRow<_i2.User>(
      $user,
      columns: [_i2.User.t.$_experienceAttendeesExperienceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Experience] and the given [Review]
  /// by setting the [Review]'s foreign key `_experienceReviewsExperienceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> reviews(
    _i1.Session session,
    _i3.Review review, {
    _i1.Transaction? transaction,
  }) async {
    if (review.id == null) {
      throw ArgumentError.notNull('review.id');
    }

    var $review = _i3.ReviewImplicit(
      review,
      $_experienceReviewsExperienceId: null,
    );
    await session.db.updateRow<_i3.Review>(
      $review,
      columns: [_i3.Review.t.$_experienceReviewsExperienceId],
      transaction: transaction,
    );
  }
}
