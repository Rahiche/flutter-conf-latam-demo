import 'dart:async';
import 'package:experience_common/experience_client.dart' as common;
import 'package:experience_marketplace/data/services/serverpod_service.dart';
import '../models/user.dart';
import 'user_repository.dart';

class ApiUserRepository implements UserRepository {
  final ServerpodService _serverpodService;
  User? _cachedCurrentUser;
  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();

  ApiUserRepository({required ServerpodService serverpodService})
      : _serverpodService = serverpodService;

  Stream<User?> get authStateChanges => _authStateController.stream;

  @override
  Future<List<User>> getAll() async {
    // Not implemented as there's no endpoint for getting all users
    return [];
  }

  @override
  Future<User?> getById(int id) async {
    try {
      final serverpodUser = await _serverpodService.users.getUser(id);
      return _convertFromServerpodUser(serverpodUser);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> create(User item) async {
    throw UnimplementedError(
        'User creation should be handled through authentication');
  }

  @override
  Future<User> update(int id, User item) async {
    throw UnimplementedError('User update not implemented via API');
  }

  @override
  Future<bool> delete(int id) async {
    throw UnimplementedError('User deletion not implemented via API');
  }

  @override
  Future<List<User>> search(String query) async {
    // Not implemented as there's no search endpoint
    return [];
  }

  @override
  Future<User?> getCurrentUser() async {
    if (_cachedCurrentUser != null) {
      return _cachedCurrentUser;
    }

    try {
      final serverpodUser = await _serverpodService.users.getMe();
      _cachedCurrentUser = _convertFromServerpodUser(serverpodUser);
      return _cachedCurrentUser;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> login(String email, String password) async {
    // Authentication is handled by serverpod_auth, not directly through our endpoints
    // This should be handled by AuthService
    throw UnimplementedError('Login should be handled through AuthService');
  }

  @override
  Future<bool> logout() async {
    // Authentication is handled by serverpod_auth
    // This should be handled by AuthService
    _cachedCurrentUser = null;
    _authStateController.add(null);
    return true;
  }

  @override
  Future<User> register(String name, String email, String password) async {
    // Registration is handled by serverpod_auth, not directly through our endpoints
    // This should be handled by AuthService
    throw UnimplementedError(
        'Registration should be handled through AuthService');
  }

  @override
  Future<bool> updateProfile(User user) async {
    throw UnimplementedError('User profile update not implemented via API');
  }

  @override
  Future<bool> addFavorite(String experienceId) async {
    // This functionality would need to be implemented on the server side
    throw UnimplementedError(
        'Favorites functionality not implemented on server');
  }

  @override
  Future<bool> removeFavorite(String experienceId) async {
    // This functionality would need to be implemented on the server side
    throw UnimplementedError(
        'Favorites functionality not implemented on server');
  }

  User _convertFromServerpodUser(common.User serverpodUser) {
    return User(
      id: serverpodUser.id.toString(),
      name: serverpodUser.userInfo?.userName ?? 'Unknown User',
      email: serverpodUser.userInfo?.email ?? '',
      joinDate: DateTime
          .now(), // serverpod User doesn't have joinDate, using current time as fallback
      avatar: serverpodUser.profilePhotoUrl,
      favoriteExperienceIds: const [], // This would need to be added to serverpod User if needed
    );
  }

  void clearCache() {
    _cachedCurrentUser = null;
  }

  void dispose() {
    _authStateController.close();
  }
}
