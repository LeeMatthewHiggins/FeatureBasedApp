abstract class Paged {
  Future<void> firstPage();
  Future<void> nextPage();
  Future<void> prevPage();
  bool hasNextPage();
  bool hasPrevPage();
}

abstract class AsyncList<T> extends Paged {
  List<T> get single;
  Stream<List<T>> get stream;
}
