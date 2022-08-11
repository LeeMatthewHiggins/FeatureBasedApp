import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/list/feature_list_viewmodel.dart';
import 'package:feature_based_app/feature/route/feature_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class FeatureTabBarView extends AsyncViewModelWidget<FeatureListViewModel> {
  final String uri;
  final bool swippable;
  late final FeatureRouter router;

  FeatureTabBarView(
      {required this.uri, this.swippable = true, FeatureRouter? router})
      : super(uri) {
    this.router = router ?? FeatureRouter();
  }

  @override
  Widget errorBuild(BuildContext context, viewmodel) {
    // TODO: implement errorBuild
    throw UnimplementedError();
  }

  @override
  Widget successBuild(BuildContext context, viewmodel) {
    final tabFeatures = viewmodel.subFeatures
        .map((uri) => router.persistantNavigationContainer(
              uri,
              embedType: FeatureEmbedType.page,
            ))
        .toList();
    return TabBarView(
        physics: swippable ? null : NeverScrollableScrollPhysics(),
        children: tabFeatures);
  }
}
