import 'package:flutter/material.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/common/provider_library.dart';
import 'package:feature_based_app/feature/feature_resolver.dart';
import '../app_widget_library.dart';
import 'feature_list_viewmodel.dart';
import 'feature_widget_library.dart';

class FeatureSliverList extends AsyncViewModelWidget<FeatureListViewModel> {
  final String uri;
  late final FeatureWidgetLibrary widgetLibrary;

  FeatureSliverList(
    this.uri, {
    ProviderLibrary? customLibrary,
    FeatureWidgetLibrary? customWidgetLibrary,
  }) : super(uri, customLibrary: customLibrary) {
    widgetLibrary = customWidgetLibrary ?? globalWidgetLibrary;
  }

  @override
  Widget errorBuild(BuildContext context, FeatureListViewModel viewmodel) {
    throw UnimplementedError();
  }

  @override
  Widget successBuild(BuildContext context, FeatureListViewModel viewmodel) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return FeatureResolver(viewmodel.subFeatures[index]);
      },
      childCount: viewmodel.subFeatures.length,
    ));
  }

  @override
  Widget pendingBuild(BuildContext context, FeatureListViewModel viewmodel) {
    return SliverToBoxAdapter(child: Center(
                        child:CircularProgressIndicator()));
  }
}
