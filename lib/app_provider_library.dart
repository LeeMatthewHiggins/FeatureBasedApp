import 'package:feature_based_app/common/repository/imp/json_bundle_repository.dart';
import 'package:feature_based_app/feature/feature_transformer.dart';
import 'common/cast_utilities.dart';
import 'common/provider_library.dart';
import 'feature/feature_bloc.dart';
import 'feature/feature_list_bloc.dart';
import 'feature/feature_list_viewmodel.dart';
import 'feature/feature_viewmodel.dart';
import 'features/cat_purchase/cat_purchase_bloc.dart';
import 'features/cat_purchase/cat_purchase_viewmodel.dart';
import 'features/rainbow_block/rainbow_block_bloc.dart';
import 'features/rainbow_block/rainbow_block_viewmodel.dart';

//final featureRepo = FirestoreRepository<Feature>(
//  firestore: FirebaseFirestore.instance,
//  transformer: FeatureTransformer(),
//);

final jsonFeatureRepo = JsonBundleRepository(
  path: 'assets/config/',
  transformer: FeatureTransformer(),
);

final globalFeatureLibrary = ProviderLibrary();


void registerGlobalProviders() {
  globalFeatureLibrary.registerProvider<FeatureViewModel>((Object? context) {
    final uri = castAssert<String>(context);
    return FeatureBloc.provider(
      uri,
      jsonFeatureRepo,
    );
  });

  globalFeatureLibrary
      .registerProvider<FeatureListViewModel>((Object? context) {
    final uri = castAssert<String>(context);
    return FeatureListBloc.provider(
      uri,
      jsonFeatureRepo,
    );
  });

  globalFeatureLibrary
      .registerProvider<RainbowBlockViewModel>((Object? context) {
    return RainbowBlockBloc.provider();
  });

  globalFeatureLibrary
      .registerProvider<CatPurchaseViewModel>((Object? context) {
    return CatPurchaseBloc.provider();
  });
}
