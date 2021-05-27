import 'package:feature_based_app/common/repository/imp/json_bundle_repository.dart';
import 'package:feature_based_app/feature/feature_transformer.dart';
import 'package:feature_based_app/features/fork/fork_business_logic.dart';
import 'package:feature_based_app/features/fork/fork_viewmodel.dart';
import 'common/cast_utilities.dart';
import 'common/provider_repository.dart';
import 'feature/feature_business_logic.dart';
import 'features/list/feature_list_business_logic.dart';
import 'features/list/feature_list_viewmodel.dart';
import 'feature/feature_viewmodel.dart';
import 'features/cat_purchase/cat_purchase_business_logic.dart';
import 'features/cat_purchase/cat_purchase_viewmodel.dart';
import 'features/rainbow/rainbow_business_logic.dart';
import 'features/rainbow/rainbow_viewmodel.dart';

//final featureRepo = FirestoreRepository<Feature>(
//  firestore: FirebaseFirestore.instance,
//  transformer: FeatureTransformer(),
//);

final jsonFeatureRepo = JsonBundleRepository(
  path: 'assets/config/features/featureRepository.json',
  transformer: FeatureTransformer(),
);

void registerGlobalProviders() {
  ProviderRepository.global.registerProviderBuilder<FeatureViewModel>(
    (Object? context) {
      final uri = castAssert<String>(context);
      return FeatureBusinessLogic(
        uri,
        jsonFeatureRepo,
      );
    },
  );

  ProviderRepository.global.registerProviderBuilder<FeatureListViewModel>(
    (Object? context) {
      final uri = castAssert<String>(context);
      return FeatureListBusinessLogic(
        uri,
        jsonFeatureRepo,
      );
    },
  );

  ProviderRepository.global.registerProviderBuilder<RainbowViewModel>(
    (Object? context) {
      return RainbowBusinessLogic();
    },
  );

  ProviderRepository.global.registerProviderBuilder<CatPurchaseViewModel>(
    (Object? context) {
      return CatPurchaseBusinessLogic();
    },
  );

  ProviderRepository.global.registerProviderBuilder<ForkViewModel>(
    (Object? context) {
      final uri = castAssert<String>(context);
      return ForkBusinessLogic(
        uri,
        jsonFeatureRepo,
      );
    },
  );
}
