/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import '../transformer.dart';

class FirestoreRepository<T> implements Repository<T> {
  final FirebaseFirestore firestore;
  final Transformer<Map<String, dynamic>, T, String> transformer;

  FirestoreRepository({
    required this.firestore,
    required this.transformer,}
  );

  @override
  Future<T> single(String uri) async {
    return firestore.doc(uri).get().then((value) {
      final data = value.data()!;
      return transformer.transform(
        data,
        identifier: value.reference.path,
      );
    });
  }

  @override
  Stream<T> stream(String uri) {
    return firestore.doc(uri).snapshots().map((event) {
      final data = event.data()!;
      return transformer.transform(
        data,
        identifier: event.reference.path,
      );
    });
  }
}*/
