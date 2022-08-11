import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/common/provider_factory.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/widget_factory.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/feature_entity.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:feature_based_app/feature/fork/fork.dart';
import 'package:feature_based_app/feature/fork/fork_business_logic.dart';
import 'package:feature_based_app/feature/fork/fork_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static const divider = '_';
}

class ForkFeature extends FeatureWidgetFactory {
  static const name = 'ForkFeature';

  final ProviderFactory providerFactory;
  final WidgetFactory widgetFactory;
  final Repository<FeatureEntity> featureRepository;
  final Future<String> Function(BuildContext) getVariant;
  final String decisionIndentifier;

  ForkFeature(
    this.providerFactory,
    this.widgetFactory,
    this.featureRepository,
    this.getVariant,
    this.decisionIndentifier,
  );

  @override
  Widget page(
    FeatureViewModel? feature,
    Object? viewModelContext,
    BuildContext context,
  ) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: view(
        feature,
        viewModelContext,
        context,
      ),
    );
  }

  @override
  Widget sliver(
    FeatureViewModel? feature,
    Object? viewModelContext,
    BuildContext context,
  ) {
    return SliverToBoxAdapter(
        child: view(
      feature,
      viewModelContext,
      context,
    ));
  }

  @override
  Widget view(
    FeatureViewModel? feature,
    Object? viewModelContext,
    BuildContext context,
  ) {
    return Fork(
      uri: feature!.uri,
      getVariant: getVariant,
    );
  }

  void register() {
    widgetFactory.registerWidgetBuilder(
      name + _Constants.divider + decisionIndentifier,
      builder,
    );
    providerFactory.registerProviderBuilder<ForkViewModel>(
      (Object? context) {
        final uri = castAssert<String>(context);
        return ForkBusinessLogic(
          uri,
          featureRepository,
        );
      },
    );
  }
}
