import 'package:feature_based_app/features/fork/fork_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/feature/feature_builder.dart';

typedef VariantFunction = String Function(String uri);

class Fork extends AsyncViewModelWidget<ForkViewModel> {
  final String uri;
  final VariantFunction getVariant;
  late final FeatureWidgetBuilder widgetBuilder;

  Fork({
    required this.uri,
    required this.getVariant,
  }) : super(uri);

  @override
  Widget errorBuild(
    BuildContext context,
    ForkViewModel viewmodel,
  ) {
    throw UnimplementedError();
  }

  @override
  Widget successBuild(
    BuildContext context,
    ForkViewModel viewmodel,
  ) {
    final defaultVariant =
        viewmodel.variants.entries.first.value; //TODO: better way to do this
    return FeatureBuilder(
        viewmodel.variants[getVariant(viewmodel.uri)] ?? defaultVariant);
  }

  @override
  Widget pendingBuild(
    BuildContext context,
    ForkViewModel viewmodel,
  ) {
    return Center(child: CircularProgressIndicator());
  }
}
