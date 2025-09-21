import 'dart:async';
import 'package:experience_common/experience_client.dart';
import 'package:experience_common/order_by.dart';
import 'package:experience_marketplace/data/services/serverpod_service.dart';

import 'experience_repository.dart';

class ApiExperienceRepository implements ExperienceRepository {
  final ServerpodService _apiService;
  List<Experience>? _cachedExperiences;
  DateTime? _lastFetchTime;
  static const Duration _cacheValidDuration = Duration(minutes: 5);

  ApiExperienceRepository({required ServerpodService apiService})
      : _apiService = apiService;

  bool get _isCacheValid {
    if (_cachedExperiences == null || _lastFetchTime == null) return false;
    return DateTime.now().difference(_lastFetchTime!) < _cacheValidDuration;
  }

  Future<List<Experience>> _fetchExperiences() async {
    if (_isCacheValid && _cachedExperiences != null) {
      return List.from(_cachedExperiences!);
    }

    try {
      final experiences = await _apiService.experiences.getExperiences(
        orderBy: ExperienceOrderBy.nameAsc.name,
        includePastEvents: false,
      );
      _cachedExperiences = experiences;
      _lastFetchTime = DateTime.now();
      return experiences;
    } catch (e) {
      if (_cachedExperiences != null) {
        return List.from(_cachedExperiences!);
      }
      return [];
    }
  }

  @override
  Future<List<Experience>> getAll() async {
    return _fetchExperiences();
  }

  @override
  Future<Experience?> getById(int id) async {
    final experience = await _apiService.experiences.getExperience(id);
    return experience;
  }

  @override
  Future<Experience> create(Experience item) async {
    _cachedExperiences?.add(item);
    return item;
  }

  @override
  Future<Experience> update(int id, Experience item) async {
    if (_cachedExperiences != null) {
      final index = _cachedExperiences!.indexWhere((e) => e.id == id);
      if (index != -1) {
        _cachedExperiences![index] = item;
        return item;
      }
    }
    throw Exception('Experience not found');
  }

  @override
  Future<bool> delete(int id) async {
    if (_cachedExperiences != null) {
      final initialLength = _cachedExperiences!.length;
      _cachedExperiences!.removeWhere((e) => e.id == id);
      return _cachedExperiences!.length < initialLength;
    }
    return false;
  }

  @override
  Future<List<Experience>> search(String query) async {
    final experiences = await _fetchExperiences();
    final lowercaseQuery = query.toLowerCase();
    return experiences.where((e) {
      return e.name.toLowerCase().contains(lowercaseQuery) ||
          e.location.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  @override
  Future<List<Experience>> getByCategory(Category category) async {
    final experiences = await _apiService.experiences
        .getExperiencesByCategory(category: category);
    return experiences;
  }

  @override
  Future<List<Review>> getReviews(String experienceId) async {
    final experience =
        await _apiService.experiences.getExperience(int.parse(experienceId));
    return experience.reviews ?? <Review>[];
  }

  @override
  Future<bool> registerAttendance(String experienceId) async {
    try {
      final result = await _apiService.experiences
          .registerAttendance(int.parse(experienceId));
      if (result) {
        // Clear cache so the updated attendance list is fetched next time
        clearCache();
      }
      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> unregisterAttendance(String experienceId) async {
    try {
      final result = await _apiService.experiences
          .unregisterAttendance(int.parse(experienceId));
      if (result) {
        // Clear cache so the updated attendance list is fetched next time
        clearCache();
      }
      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> reportExperience(int experienceId) async {
    // Mock implementation for slide demonstration
    await Future.delayed(const Duration(milliseconds: 500));

    // Simulate adding to reported queue
    print(
        'Experience $experienceId has been reported and added to review queue');

    // Clear cache so the updated list is fetched next time
    clearCache();
    return true;
  }

  void clearCache() {
    _cachedExperiences = null;
    _lastFetchTime = null;
  }
}
