import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/common/provider_factory.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/widget_factory.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/feature_entity.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:feature_based_app/feature/list/feature_list_business_logic.dart';
import 'package:feature_based_app/feature/list/feature_list_menu.dart';
import 'package:feature_based_app/feature/list/feature_list_viewmodel.dart';
import 'package:feature_based_app/feature/list/feature_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeatureStack extends FeatureWidgetFactory {
  static const name = 'ListFeature';

  final ProviderFactory providerFactory;
  final WidgetFactory widgetFactory;
  final Repository<FeatureEntity> featureRepository;

  FeatureStack(
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
    return Scaffold(
      body: view(feature, viewModelContext, context),
    );
  }

  @override
  Widget sliver(
    FeatureViewModel? feature,
    Object? viewModelContext,
    BuildContext context,
  ) {
    return FeatureSliverList(
      uri: feature!.uri,
    );
  }

  @override
  Widget view(FeatureViewModel? feature, Object? viewModelContext,
      BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        sliver(
          feature,
          viewModelContext,
          context,
        )
      ],
    );
  }
}

class FeatureMenu extends FeatureWidgetFactory {
  static const name = 'pageList';

  final ProviderFactory providerFactory;
  final WidgetFactory widgetFactory;
  final Repository<FeatureEntity> featureRepository;

  FeatureMenu(
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
    return Scaffold(
      body: view(feature, viewModelContext, context),
    );
  }

  @override
  Widget sliver(
    FeatureViewModel? feature,
    Object? viewModelContext,
    BuildContext context,
  ) {
    throw UnimplementedError();
  }

  @override
  Widget view(FeatureViewModel? feature, Object? viewModelContext,
      BuildContext context) {
    return FeatureListMenu(uri: feature!.uri);
  }
}

class ListFeature {
  final ProviderFactory providerFactory;
  final WidgetFactory widgetFactory;
  final Repository<FeatureEntity> featureRepository;

  ListFeature(
    this.providerFactory,
    this.widgetFactory,
    this.featureRepository,
  );

  void register() {
    final stack = FeatureStack(
      providerFactory,
      widgetFactory,
      featureRepository,
    );
    final menu = FeatureMenu(
      providerFactory,
      widgetFactory,
      featureRepository,
    );
    widgetFactory.registerWidgetBuilder(
      FeatureStack.name,
      stack.builder,
    );
    widgetFactory.registerWidgetBuilder(
      FeatureMenu.name,
      menu.builder,
    );
    providerFactory.registerProviderBuilder<FeatureListViewModel>(
      (Object? context) {
        final uri = castAssert<String>(context);
        return FeatureListBusinessLogic(
          uri,
          featureRepository,
        );
      },
    );
  }
}
