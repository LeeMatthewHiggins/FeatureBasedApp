import 'package:feature_based_app/common/repository/paged.dart';
import 'package:feature_based_app/feature_based_app.dart';

enum SortType { None, Temporal, Numerical, Alphabetical }

abstract class Repository<T extends Identifiable> {
  Future<T> single(String uri, {T? defaultObject});
  Stream<T> stream(String uri);
  Future<T> update(
    String? uri,
    T data,
  );
  Future<void> remove(String uri);
  Future<List<T>> collection(List<String> uris);
  Stream<List<T>> streamCollection(List<String> uris);

  AsyncList<T> matching({
    required Map<String, bool?> tags,
    SortType sortBy = SortType.None,
  });
}
