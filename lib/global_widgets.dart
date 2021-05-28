import 'package:feature_based_app/common/widget_repository.dart';
import 'package:feature_based_app/feature/feature_description_view.dart';
import 'package:feature_based_app/features/list/feature_list_page.dart';
import 'package:feature_based_app/features/cat_purchase/cat_purchase_view.dart';
import 'package:feature_based_app/features/fork/fork.dart';
import 'package:feature_based_app/features/list/feature_sliver_list.dart';
import 'package:feature_based_app/features/rainbow/rainbow_view.dart';

String _testVariant(String uri) {
  return 'b';
}

String _userVariant(String uri) {
  return 'unauthorised';
}

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
    'pageList',
    (context) => FeatureListPage(
      uri: context as String,
    ),
  );
  WidgetRepository.global.registerWidgetBuilder(
    'list',
    (context) => FeatureSliverList(
      uri: context as String,
    ),
  );
  WidgetRepository.global.registerWidgetBuilder(
    'ab_test',
    (context) => Fork(
      uri: context as String,
      getVariant: _testVariant,
    ),
  );
  WidgetRepository.global.registerWidgetBuilder(
    'authFork',
    (context) => Fork(
      uri: context as String,
      getVariant: _userVariant,
    ),
  );
}
