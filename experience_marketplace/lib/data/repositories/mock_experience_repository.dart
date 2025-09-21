import 'dart:async';
import 'package:experience_common/experience_client.dart';
import 'package:experience_marketplace/data/repositories/experience_repository.dart';

class MockExperienceRepository implements ExperienceRepository {
  MockExperienceRepository() {
    _seed();
  }

  final List<Experience> _experiences = [];

  void _seed() {
    _experiences.clear();

    _experiences.addAll([
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
      Experience(
        id: 106,
        name: 'Galapagos Island Hopping: Santa Cruz & Isabela',
        location: 'Galapagos Islands, Ecuador',
        photoUrl: 'https://i.imgur.com/aDshbXx.png',
        startsAt: DateTime.parse('2025-11-02T11:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-07T12:00:00.000Z'),
        categoryId: 3,
        reviews: [Review(score: 5, userId: 6)],
      ),
      Experience(
        id: 107,
        name: 'Cotopaxi Volcano Acclimatization Hike',
        location: 'Cotopaxi National Park, Cotopaxi',
        photoUrl:
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?q=80&w=2070',
        startsAt: DateTime.parse('2025-11-09T07:30:00.000Z'),
        endsAt: DateTime.parse('2025-11-09T16:00:00.000Z'),
        categoryId: 1,
        reviews: [Review(score: 5, userId: 7)],
      ),
      Experience(
        id: 108,
        name: 'Baños \'Swing at the End of the World\'',
        location: 'Baños de Agua Santa, Tungurahua',
        photoUrl: 'https://i.imgur.com/imB3jHN.png',
        startsAt: DateTime.parse('2025-11-11T10:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-11T13:00:00.000Z'),
        categoryId: 1,
        reviews: [Review(score: 5, userId: 8)],
      ),
      Experience(
        id: 109,
        name: 'Ecuadorian Chocolate Making Class',
        location: 'Quito, Pichincha',
        photoUrl: 'https://i.imgur.com/2cJmrSS.png',
        startsAt: DateTime.parse('2025-11-12T14:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-12T16:30:00.000Z'),
        categoryId: 4,
        reviews: [Review(score: 5, userId: 9)],
      ),
      Experience(
        id: 110,
        name: 'Canyoning and Waterfall Rappelling in Baños',
        location: 'Baños de Agua Santa, Tungurahua',
        photoUrl: 'https://i.imgur.com/NCi7Ixu.png',
        startsAt: DateTime.parse('2025-11-13T09:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-13T13:00:00.000Z'),
        categoryId: 1,
        reviews: [Review(score: 5, userId: 10)],
      ),
      Experience(
        id: 111,
        name: 'Cuenca Colonial City Walking Tour',
        location: 'Cuenca, Azuay',
        photoUrl: 'https://i.imgur.com/J4WeBER.png',
        startsAt: DateTime.parse('2025-11-15T10:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-15T14:00:00.000Z'),
        categoryId: 2,
        reviews: [Review(score: 5, userId: 11)],
      ),
      Experience(
        id: 112,
        name: 'Visit a Panama Hat Workshop',
        location: 'Montecristi, Manabí',
        photoUrl: 'https://i.imgur.com/cxZDGS3.png',
        startsAt: DateTime.parse('2025-11-17T11:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-17T13:00:00.000Z'),
        categoryId: 2,
        reviews: [Review(score: 4, userId: 12)],
      ),
      Experience(
        id: 113,
        name: 'Devil\'s Nose Train Ride Adventure',
        location: 'Alausí, Chimborazo',
        photoUrl: 'https://i.imgur.com/cJSCD5P.png',
        startsAt: DateTime.parse('2025-11-18T08:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-18T13:00:00.000Z'),
        categoryId: 1,
        reviews: [Review(score: 4, userId: 13)],
      ),
      Experience(
        id: 114,
        name: 'Whale Watching in Puerto Lopez',
        location: 'Puerto Lopez, Manabí',
        photoUrl: 'https://i.imgur.com/RSVhJsI.png',
        startsAt: DateTime.parse('2025-07-20T09:30:00.000Z'),
        endsAt: DateTime.parse('2025-07-20T13:30:00.000Z'),
        categoryId: 3,
        reviews: [Review(score: 5, userId: 14)],
      ),
      Experience(
        id: 115,
        name: 'Papallacta Volcanic Hot Springs Relaxation',
        location: 'Papallacta, Napo',
        photoUrl: 'https://i.imgur.com/MufzEsK.png',
        startsAt: DateTime.parse('2025-11-20T10:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-20T18:00:00.000Z'),
        categoryId: 5,
        reviews: [Review(score: 5, userId: 15)],
      ),
      Experience(
        id: 116,
        name: 'Surfing Lessons in Montañita',
        location: 'Montañita, Santa Elena',
        photoUrl: 'https://i.imgur.com/3Ki7qjb.png',
        startsAt: DateTime.parse('2025-11-22T09:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-22T11:00:00.000Z'),
        categoryId: 1,
        reviews: [Review(score: 4, userId: 16)],
      ),
      Experience(
        id: 117,
        name: 'Ingapirca Ruins Historical Tour',
        location: 'Ingapirca, Cañar Province',
        photoUrl: 'https://i.imgur.com/N3bDxXu.png',
        startsAt: DateTime.parse('2025-11-23T10:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-23T14:00:00.000Z'),
        categoryId: 2,
        reviews: [Review(score: 4, userId: 17)],
      ),
      Experience(
        id: 118,
        name: 'Andean Coffee Plantation Tour & Tasting',
        location: 'Intag Valley, Imbabura',
        photoUrl:
            'https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?q=80&w=2070',
        startsAt: DateTime.parse('2025-11-25T09:30:00.000Z'),
        endsAt: DateTime.parse('2025-11-25T13:30:00.000Z'),
        categoryId: 4,
        reviews: [Review(score: 5, userId: 18)],
      ),
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
        id: 119,
        name: 'Kayaking with Sea Lions in the Galapagos',
        location: 'Gardner Bay, Española Island, Galapagos',
        photoUrl: 'https://i.imgur.com/pbnxvAz.png',
        startsAt: DateTime.parse('2025-11-04T13:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-04T15:00:00.000Z'),
        categoryId: 3,
        reviews: [Review(score: 5, userId: 19)],
      ),
      Experience(
        id: 120,
        name: 'Explore the Waterfalls of Giron',
        location: 'Giron, Azuay',
        photoUrl: 'https://i.imgur.com/D5wdEFs.png',
        startsAt: DateTime.parse('2025-11-26T09:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-26T14:00:00.000Z'),
        categoryId: 1,
        reviews: [Review(score: 4, userId: 20)],
      ),
      Experience(
        id: 121,
        name: 'Quito Basilica del Voto Nacional Tower Climb',
        location: 'Quito, Pichincha',
        photoUrl: 'https://i.imgur.com/XYfPPre.png',
        startsAt: DateTime.parse('2025-11-28T11:00:00.000Z'),
        endsAt: DateTime.parse('2025-11-28T12:30:00.000Z'),
        categoryId: 2,
        reviews: [Review(score: 5, userId: 21)],
      ),
      Experience(
        id: 122,
        name: 'Cuyabeno Wildlife Reserve Canoe Trip',
        location: 'Cuyabeno Wildlife Reserve, Sucumbíos',
        photoUrl: 'https://i.imgur.com/ELkaJhM.png',
        startsAt: DateTime.parse('2025-11-29T09:00:00.000Z'),
        endsAt: DateTime.parse('2025-12-02T15:00:00.000Z'),
        categoryId: 3,
        reviews: [Review(score: 5, userId: 22)],
      ),
      Experience(
        id: 123,
        name: 'Traditional Ecuadorian Cooking Experience',
        location: 'Cuenca, Azuay',
        photoUrl: 'https://i.imgur.com/VzylqAT.png',
        startsAt: DateTime.parse('2025-12-04T17:00:00.000Z'),
        endsAt: DateTime.parse('2025-12-04T20:00:00.000Z'),
        categoryId: 4,
        reviews: [Review(score: 5, userId: 23)],
      ),
      Experience(
        id: 124,
        name: 'Climb to the Refuge on Chimborazo Volcano',
        location: 'Chimborazo Province, Ecuador',
        photoUrl:
            'https://images.unsplash.com/photo-1587529532243-524185c4f2b8?q=80&w=2070',
        startsAt: DateTime.parse('2025-12-06T06:00:00.000Z'),
        endsAt: DateTime.parse('2025-12-06T16:00:00.000Z'),
        categoryId: 1,
        reviews: [Review(score: 5, userId: 24)],
      ),
      Experience(
        id: 125,
        name: 'Snorkeling at Kicker Rock (León Dormido)',
        location: 'San Cristobal Island, Galapagos',
        photoUrl: 'https://i.imgur.com/Inzpjph.png',
        startsAt: DateTime.parse('2025-11-06T08:30:00.000Z'),
        endsAt: DateTime.parse('2025-11-06T14:00:00.000Z'),
        categoryId: 3,
        reviews: [Review(score: 5, userId: 25)],
      ),
    ]);
  }

  // --- All other methods remain the same ---
  @override
  Future<List<Experience>> getAll() async {
    _seed();
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
  Future<bool> reportExperience(int experienceId) {
    throw UnimplementedError();
  }
}
