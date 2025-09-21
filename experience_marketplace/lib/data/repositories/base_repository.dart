abstract class BaseRepository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<T> create(T item);
  Future<T> update(int id, T item);
  Future<bool> delete(int id);
  Future<List<T>> search(String query);
}
