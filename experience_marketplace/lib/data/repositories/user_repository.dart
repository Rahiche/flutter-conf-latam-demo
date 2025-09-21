import 'dart:async';
import '../models/user.dart';
import '../mock/mock_data.dart';
import 'base_repository.dart';

abstract class UserRepository extends BaseRepository<User> {
  Future<User?> getCurrentUser();
  Future<bool> login(String email, String password);
  Future<bool> logout();
  Future<User> register(String name, String email, String password);
  Future<bool> updateProfile(User user);
  Future<bool> addFavorite(String experienceId);
  Future<bool> removeFavorite(String experienceId);
}

class MockUserRepository implements UserRepository {
  final List<User> _users = [...MockData.users];
  User? _currentUser = MockData.currentUser;
  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();

  Stream<User?> get authStateChanges => _authStateController.stream;

  @override
  Future<List<User>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_users);
  }

  @override
  Future<User?> getById(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _users.firstWhere((u) => u.id == id.toString());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<User> create(User item) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _users.add(item);
    return item;
  }

  @override
  Future<User> update(int id, User item) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _users.indexWhere((u) => u.id == id.toString());
    if (index != -1) {
      _users[index] = item;
      if (_currentUser?.id == id.toString()) {
        _currentUser = item;
        _authStateController.add(item);
      }
      return item;
    }
    throw Exception('User not found');
  }

  @override
  Future<bool> delete(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final initialLength = _users.length;
    _users.removeWhere((u) => u.id == id.toString());
    return _users.length < initialLength;
  }

  @override
  Future<List<User>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final lowercaseQuery = query.toLowerCase();
    return _users.where((u) {
      return u.name.toLowerCase().contains(lowercaseQuery) ||
          u.email.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _currentUser;
  }

  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    // Mock authentication - accept any email from our users list
    try {
      _currentUser = _users.firstWhere((u) => u.email == email);
      _authStateController.add(_currentUser);
      return true;
    } catch (_) {
      // For demo, create a new user if email not found
      if (email.contains('@')) {
        final newUser = User(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          name: email.split('@')[0],
          email: email,
          joinDate: DateTime.now(),
        );
        _users.add(newUser);
        _currentUser = newUser;
        _authStateController.add(_currentUser);
        return true;
      }
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _authStateController.add(null);
    return true;
  }

  @override
  Future<User> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    // Check if user already exists
    if (_users.any((u) => u.email == email)) {
      throw Exception('User with this email already exists');
    }

    final newUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      joinDate: DateTime.now(),
      avatar: 'https://i.pravatar.cc/150?img=${_users.length + 1}',
    );

    _users.add(newUser);
    _currentUser = newUser;
    _authStateController.add(newUser);
    return newUser;
  }

  @override
  Future<bool> updateProfile(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return (await update(int.parse(user.id), user)) == user;
  }

  @override
  Future<bool> addFavorite(String experienceId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_currentUser == null) return false;

    final updatedFavorites = [..._currentUser!.favoriteExperienceIds];
    if (!updatedFavorites.contains(experienceId)) {
      updatedFavorites.add(experienceId);
      _currentUser =
          _currentUser!.copyWith(favoriteExperienceIds: updatedFavorites);
      await update(int.parse(_currentUser!.id), _currentUser!);
      return true;
    }
    return false;
  }

  @override
  Future<bool> removeFavorite(String experienceId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_currentUser == null) return false;

    final updatedFavorites = [..._currentUser!.favoriteExperienceIds];
    if (updatedFavorites.remove(experienceId)) {
      _currentUser =
          _currentUser!.copyWith(favoriteExperienceIds: updatedFavorites);
      await update(int.parse(_currentUser!.id), _currentUser!);
      return true;
    }
    return false;
  }

  void dispose() {
    _authStateController.close();
  }
}
