import 'dart:async';
import 'package:experience_common/experience_client.dart';
import 'package:experience_marketplace/data/repositories/experience_repository.dart';

class FlutterLatamExperienceRepository implements ExperienceRepository {
  FlutterLatamExperienceRepository() {
    _seed();
  }

  final List<Experience> _experiences = [];

  void _seed() {
    _experiences.clear();

    _experiences.addAll([
      Experience(
        id: 100,
        name: 'Flutter Conf Latam',
        location: 'Quito, Ecuador',
        photoUrl: 'https://i.imgur.com/EztETAJ.png',
        startsAt: DateTime.now().subtract(const Duration(minutes: 30)),
        endsAt: DateTime.now().add(const Duration(hours: 2)),
        categoryId: 2,
        reviews: [Review(score: 5, userId: 1)],
      ),
      Experience(
        id: 101,
        name: 'Hike to Quilotoa Crater Lake',
        location: 'Quilotoa, Cotopaxi Province',
        photoUrl:
            'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=2070',
        startsAt: DateTime.parse('2025-10-20T07:00:00.000Z'),
        endsAt: DateTime.parse('2025-10-20T17:00:00.000Z'),
        categoryId: 1,
        reviews: [Review(score: 5, userId: 1)],
      ),
      Experience(
        id: 102,
        name: 'Historic Quito City Tour & Equator Line',
        location: 'Quito, Pichincha',
        photoUrl: 'https://i.imgur.com/RG9Uodk.png',
        startsAt: DateTime.parse('2025-10-22T09:00:00.000Z'),
        endsAt: DateTime.parse('2025-10-22T16:00:00.000Z'),
        categoryId: 2,
        reviews: [Review(score: 5, userId: 2)],
      ),
      Experience(
        id: 103,
        name: 'Mindo Cloud Forest Ziplining & Birdwatching',
        location: 'Mindo, Pichincha',
        photoUrl: 'https://i.imgur.com/jGAo4xz.png',
        startsAt: DateTime.parse('2025-10-24T08:30:00.000Z'),
        endsAt: DateTime.parse('2025-10-24T17:00:00.000Z'),
        categoryId: 1,
        reviews: [Review(score: 5, userId: 3)],
      ),
      Experience(
        id: 104,
        name: 'Amazon Rainforest Jungle Expedition',
        location: 'Yasuni National Park, Orellana Province',
        photoUrl: 'https://i.imgur.com/nRf7hnA.png',
        startsAt: DateTime.parse('2025-10-26T10:00:00.000Z'),
        endsAt: DateTime.parse('2025-10-29T14:00:00.000Z'),
        categoryId: 3,
        reviews: [Review(score: 5, userId: 4)],
      ),
      Experience(
        id: 105,
        name: 'Otavalo Market Cultural Shopping Day',
        location: 'Otavalo, Imbabura',
        photoUrl: 'https://i.imgur.com/ebEaBa3.png',
        startsAt: DateTime.parse('2025-10-30T08:00:00.000Z'),
        endsAt: DateTime.parse('2025-10-30T15:00:00.000Z'),
        categoryId: 2,
        reviews: [Review(score: 4, userId: 5)],
      ),
    ]);
  }

  // --- All other methods remain the same ---
  @override
  Future<List<Experience>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_experiences);
  }

  @override
  Future<Experience?> getById(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _experiences.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Experience> create(Experience item) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _experiences.add(item);
    return item;
  }

  @override
  Future<Experience> update(int id, Experience item) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _experiences.indexWhere((e) => e.id == id);
    if (index != -1) {
      _experiences[index] = item;
      return item;
    }
    throw Exception('Experience not found');
  }

  @override
  Future<bool> delete(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final initial = _experiences.length;
    _experiences.removeWhere((e) => e.id == id);
    return _experiences.length < initial;
  }

  @override
  Future<List<Experience>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final q = query.toLowerCase();
    return _experiences
        .where((e) =>
            e.name.toLowerCase().contains(q) ||
            e.location.toLowerCase().contains(q))
        .toList();
  }

  @override
  Future<List<Experience>> getByCategory(Category category) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _experiences
        .where((e) => e.categoryId == (category.id ?? -1))
        .toList();
  }

  @override
  Future<List<Review>> getReviews(String experienceId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final id = int.tryParse(experienceId);
    if (id == null) return <Review>[];
    final exp = await getById(id);
    return exp?.reviews ?? <Review>[];
  }

  @override
  Future<bool> registerAttendance(String experienceId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Future<bool> unregisterAttendance(String experienceId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Future<bool> reportExperience(int experienceId) async {
    // Enhanced reporting functionality for the Flutter Latam demo
    await Future.delayed(const Duration(milliseconds: 500));
    // Return true to indicate successful reporting
    return true;
  }
}
