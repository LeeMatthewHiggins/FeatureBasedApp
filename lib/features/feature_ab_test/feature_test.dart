import 'package:flutter/material.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/feature/feature_builder.dart';

import 'feature_variant_viewmodel.dart';

class FeatureVariant extends AsyncViewModelWidget<FeatureVariantViewModel> {
  final String uri;
  final String _variant = 'a'; //TODO: add a function to get Variant
  late final FeatureWidgetBuilder widgetBuilder;

  FeatureVariant({required this.uri}) : super(uri);

  @override
  Widget errorBuild(
    BuildContext context,
    FeatureVariantViewModel viewmodel,
  ) {
    throw UnimplementedError();
  }

  @override
  Widget successBuild(
    BuildContext context,
    FeatureVariantViewModel viewmodel,
  ) {
        final defaultVariant = viewmodel
            .variants.entries.first.value; //TODO: better way to do this
        return FeatureBuilder(viewmodel.variants[_variant] ?? defaultVariant);
  }

  @override
  Widget pendingBuild(
    BuildContext context,
    FeatureVariantViewModel viewmodel,
  ) {
    return Center(child: CircularProgressIndicator());
  }
}
