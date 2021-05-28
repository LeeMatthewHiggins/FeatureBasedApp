import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/feature_sliver_builder.dart';
import 'package:feature_based_app/features/list/feature_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeatureListPage extends AsyncViewModelWidget<FeatureListViewModel> {
  final String uri;
  late final FeatureWidgetBuilder widgetBuilder;

  FeatureListPage({required this.uri}) : super(uri);

  @override
  Widget errorBuild(
    BuildContext context,
    FeatureListViewModel viewmodel,
  ) {
    throw UnimplementedError();
  }

  @override
  Widget successBuild(
    BuildContext context,
    FeatureListViewModel viewmodel,
  ) {
    final featureWidgets = viewmodel.subFeatures
        .map((feature) => FeatureSliverBuilder(feature))
        .toList();
    return Scaffold(
      body: SafeArea(child:CustomScrollView(
        slivers: featureWidgets,
      )),
    );
  }

  @override
  Widget pendingBuild(
    BuildContext context,
    FeatureListViewModel viewmodel,
  ) {
    return Center(child: CircularProgressIndicator());
  }
}
