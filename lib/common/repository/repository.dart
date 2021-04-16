abstract class Repository<T> {
   Future<T> single(String uri);
   Stream<T> stream(String uri);
}