import 'package:feature_based_app/common/platform_detection.dart';
import 'package:feature_based_app/common/provider_factory.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/widget_factory.dart';
import 'package:feature_based_app/feature/description_feature.dart';
import 'package:feature_based_app/feature/feature_entity.dart';
import 'package:feature_based_app/feature/fork/fork_feature.dart';
import 'package:feature_based_app/feature/list/list_feature.dart';
import 'package:feature_based_app/feature/tab/tab_feature.dart';

void registerFeatureBasedBuildingBlocks(Repository<FeatureEntity> repository) {
  final defaultFeature = DescriptionFeature(
    ProviderFactory.global,
    WidgetFactory.global,
    repository,
  );
  WidgetFactory.global.registerDefaultWidgetBuilder(defaultFeature.builder);
  defaultFeature.register();

  ListFeature(
    ProviderFactory.global,
    WidgetFactory.global,
    repository,
  ).register();

  TabFeature(
    ProviderFactory.global,
    WidgetFactory.global,
    repository,
  ).register();

  ForkFeature(
    ProviderFactory.global,
    WidgetFactory.global,
    repository,
    (context) {
      return _getPlatform();
    },
    'platform',
  ).register();
}

Future<String> _getPlatform() async {
  return PlatformDetector.getPlatform();
}
