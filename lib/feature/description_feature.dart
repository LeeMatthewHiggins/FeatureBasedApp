import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/common/provider_factory.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/widget_factory.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/feature_business_logic.dart';
import 'package:feature_based_app/feature/feature_description_view.dart';
import 'package:feature_based_app/feature/feature_entity.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DescriptionFeature extends FeatureWidgetFactory {
  static const name = 'DescriptionFeature';

  final ProviderFactory providerFactory;
  final WidgetFactory widgetFactory;
  final Repository<FeatureEntity> featureRepository;

  DescriptionFeature(
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
    return FeatureDescriptionView(
      uri: feature!.uri,
    );
  }

  void register() {
    widgetFactory.registerWidgetBuilder(
      name,
      builder,
    );
    providerFactory.registerProviderBuilder<FeatureViewModel>(
      (Object? context) {
        final uri = castAssert<String>(context);
        return FeatureBusinessLogic(
          uri,
          featureRepository,
        );
      },
    );
  }
}
