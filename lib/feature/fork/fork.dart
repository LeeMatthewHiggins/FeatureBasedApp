import 'package:feature_based_app/feature/fork/fork_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/feature/feature_builder.dart';

typedef VariantFunction = Future<String> Function(BuildContext context);

class Fork extends AsyncViewModelWidget<ForkViewModel> {
  final String uri;
  final FeatureEmbedType embedType;
  final VariantFunction getVariant;
  late final FeatureWidgetBuilder widgetBuilder;

  Fork({
    required this.uri,
    required this.getVariant,
    this.embedType = FeatureEmbedType.view,
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
    return FutureBuilder<String>(
        future: getVariant(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FeatureBuilder(
              uri: viewmodel.variants[snapshot.data] ?? defaultVariant,
              embedType: embedType,
            );
          }
          return pendingBuild(context, viewmodel);
        });
  }

  @override
  Widget pendingBuild(
    BuildContext context,
    ForkViewModel viewmodel,
  ) {
    return Center(child: CircularProgressIndicator());
  }
}
