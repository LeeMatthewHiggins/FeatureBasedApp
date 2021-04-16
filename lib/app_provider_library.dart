import 'package:feature_based_app/common/repository/imp/json_bundle_repository.dart';
import 'package:feature_based_app/feature/feature_transformer.dart';
import 'common/provider_library.dart';

//final featureRepo = FirestoreRepository<Feature>(
//  firestore: FirebaseFirestore.instance,
//  transformer: FeatureTransformer(),
//);

final jsonFeatureRepo = JsonBundleRepository(
  path: 'assets/config/',
  transformer: FeatureTransformer(),
);

final globalFeatureLibrary = ProviderLibrary();
