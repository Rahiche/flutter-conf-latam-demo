import 'package:experience_common/experience_client.dart';
import 'package:experience_marketplace/data/repositories/category_repository.dart';

class MockCategoryRepository extends CategoryRepository {
  final List<Category> _categories = [
    Category(
        id: 1,
        name: 'Adventure',
        iconUrl:
            'https://img.icons8.com/?size=100&id=59873&format=png&color=FFFFFF'),
    Category(
        id: 2,
        name: 'Culture',
        iconUrl:
            'https://img.icons8.com/?size=100&id=59873&format=png&color=FFFFFF'),
    Category(
        id: 3,
        name: 'Food & Drink',
        iconUrl:
            'https://img.icons8.com/?size=100&id=59873&format=png&color=FFFFFF'),
    Category(
        id: 4,
        name: 'Nature',
        iconUrl:
            'https://img.icons8.com/?size=100&id=59873&format=png&color=FFFFFF'),
    Category(
        id: 5,
        name: 'Arts',
        iconUrl:
            'https://img.icons8.com/?size=100&id=59873&format=png&color=FFFFFF'),
  ];

  @override
  Future<List<Category>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_categories);
  }

  @override
  Future<Category?> getById(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _categories.where((c) => c.id == id).cast<Category?>().firstOrNull;
  }

  @override
  Future<List<Category>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final q = query.toLowerCase();
    return _categories.where((c) => c.name.toLowerCase().contains(q)).toList();
  }

  // Mutations are no-op in mock.
  @override
  Future<Category> create(Category item) async => item;

  @override
  Future<Category> update(int id, Category item) async => item;

  @override
  Future<bool> delete(int id) async => true;
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
