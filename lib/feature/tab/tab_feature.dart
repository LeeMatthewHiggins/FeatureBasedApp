import 'package:feature_based_app/common/provider_factory.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/widget_factory.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/feature_entity.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:feature_based_app/feature/tab/feature_bottom_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabFeature extends FeatureWidgetFactory {
  static const name = 'TabFeature';

  final ProviderFactory providerFactory;
  final WidgetFactory widgetFactory;
  final Repository<FeatureEntity> featureRepository;

  TabFeature(
    this.providerFactory,
    this.widgetFactory,
    this.featureRepository,
  );

  @override
  Widget page(
    FeatureViewModel? feature,
    Object? viewModelContext,
    BuildContext context,
  ) {
    return FeatureBottomTabBarPage(
      uri: feature!.uri,
    );
  }

  @override
  Widget sliver(
    FeatureViewModel? feature,
    Object? viewModelContext,
    BuildContext context,
  ) {
    throw UnimplementedError('TabFeature has no sliver embedding');
  }

  @override
  Widget view(
    FeatureViewModel? feature,
    Object? viewModelContext,
    BuildContext context,
  ) {
    throw UnimplementedError('TabFeature has no view embedding');
  }

  void register() {
    widgetFactory.registerWidgetBuilder(
      name,
      builder,
    );
  }
}
