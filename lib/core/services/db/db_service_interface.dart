import 'package:about_you/constants/global_settings.dart';

abstract class IDBService<T> {
  Future<List<T>> read(
      {Map<String, dynamic>? queries,
      int limit = Constants.queryLimits,
      int page = 0});
  Future<T?> readById(dynamic id);
  Future<T> write(T item);
  Future<bool> delete(Map<String, dynamic> ids);
  Future<T> update(T item);
  Stream<List<T>> stream(Map<String, dynamic>? queries);
}
