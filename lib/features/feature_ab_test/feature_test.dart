import 'package:flutter/material.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/feature/feature_builder.dart';

import 'feature_test_viewmodel.dart';

class FeatureTest extends AsyncViewModelWidget<FeatureTestViewModel> {
  final String uri;
  final String _variant = 'a'; //TODO: add a function to get Variant
  late final FeatureWidgetBuilder widgetBuilder;

  FeatureTest({required this.uri}) : super(uri);

  @override
  Widget errorBuild(
    BuildContext context,
    FeatureTestViewModel viewmodel,
  ) {
    throw UnimplementedError();
  }

  @override
  Widget successBuild(
    BuildContext context,
    FeatureTestViewModel viewmodel,
  ) {
        final defaultVariant = viewmodel
            .variants.entries.first.value; //TODO: better way to do this
        return FeatureBuilder(viewmodel.variants[_variant] ?? defaultVariant);
  }

  @override
  Widget pendingBuild(
    BuildContext context,
    FeatureTestViewModel viewmodel,
  ) {
    return Center(child: CircularProgressIndicator());
  }
}
