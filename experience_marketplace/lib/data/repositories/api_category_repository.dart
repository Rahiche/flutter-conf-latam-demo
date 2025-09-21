import 'package:experience_common/experience_client.dart';
import 'package:experience_marketplace/data/repositories/category_repository.dart';
import 'package:experience_marketplace/data/services/serverpod_service.dart';

class ApiCategoryRepository extends CategoryRepository {
  final ServerpodService _apiService;
  List<Category>? _cachedCategories;
  DateTime? _lastFetchTime;
  static const Duration _cacheValidDuration = Duration(minutes: 5);

  ApiCategoryRepository({required ServerpodService apiService})
      : _apiService = apiService;

  bool get _isCacheValid {
    if (_cachedCategories == null || _lastFetchTime == null) return false;
    return DateTime.now().difference(_lastFetchTime!) < _cacheValidDuration;
  }

  Future<List<Category>> _fetchCategories() async {
    if (_isCacheValid && _cachedCategories != null) {
      return List.from(_cachedCategories!);
    }

    try {
      final categories = await _apiService.categories.getCategories();
      _cachedCategories = categories;
      _lastFetchTime = DateTime.now();
      return categories;
    } catch (e) {
      if (_cachedCategories != null) {
        return List.from(_cachedCategories!);
      }
      return [];
    }
  }

  @override
  Future<Category> create(Category item) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getAll() async {
    return _fetchCategories();
  }

  @override
  Future<Category?> getById(int id) {
    return _apiService.categories.getCategory(id);
  }

  @override
  Future<List<Category>> search(String query) {
    throw UnimplementedError();
  }

  @override
  Future<Category> update(int id, Category item) {
    throw UnimplementedError();
  }
}
