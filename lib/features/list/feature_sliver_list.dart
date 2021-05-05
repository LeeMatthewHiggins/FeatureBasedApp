import 'package:feature_based_app/app_widget_factory.dart';
import 'package:feature_based_app/features/list/feature_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/feature/feature_builder.dart';

class FeatureSliverList extends AsyncViewModelWidget<FeatureListViewModel> {
  final String uri;
  late final FeatureWidgetBuilder widgetBuilder;

  FeatureSliverList(
    this.uri, {
    FeatureWidgetBuilder? customWidgetBuilder,
  }) : super(uri) {
    widgetBuilder = customWidgetBuilder ?? globalWidgetBuilder;
  }

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
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return FeatureBuilder(
          viewmodel.subFeatures[index],
          customWidgetBuilder: widgetBuilder,
        );
      },
      childCount: viewmodel.subFeatures.length,
    ));
  }

  @override
  Widget pendingBuild(
    BuildContext context,
    FeatureListViewModel viewmodel,
  ) {
    return SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()));
  }
}
