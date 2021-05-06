import 'package:feature_based_app/common/widget_repository.dart';
import 'package:feature_based_app/feature/feature_list_description_page.dart';
import 'package:feature_based_app/feature/feature_description_view.dart';
import 'package:feature_based_app/features/cat_purchase/cat_purchase_view.dart';
import 'package:feature_based_app/features/rainbow/rainbow_view.dart';

void registerGlobalWidgets() {
  WidgetRepository.global.registerDefaultWidgetBuilder(
    (context) => FeatureDescriptionView(
      uri: context as String,
    ),
  );
  WidgetRepository.global.registerWidgetBuilder(
    'cats',
    (context) => CatShopView(),
  );
  WidgetRepository.global.registerWidgetBuilder(
    'rainbow',
    (context) => RainbowView(),
  );
  WidgetRepository.global.registerWidgetBuilder(
    'list',
    (context) => FeatureListDescriptionPage(
      uri: context as String,
    ),
  );
}
