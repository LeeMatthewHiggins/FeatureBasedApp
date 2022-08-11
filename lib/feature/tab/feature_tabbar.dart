import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/feature/list/feature_list_viewmodel.dart';
import 'package:feature_based_app/feature/tab/feature_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class FeatureTabBarView extends AsyncViewModelWidget<FeatureListViewModel> {
  final String uri;

  FeatureTabBarView({required this.uri}) : super(uri);

  @override
  Widget errorBuild(BuildContext context, FeatureListViewModel viewmodel) {
    // TODO: implement errorBuild
    throw UnimplementedError();
  }

  @override
  Widget successBuild(BuildContext context, FeatureListViewModel viewmodel) {
    final tabs =
        viewmodel.subFeatures.map((uri) => FeatureTab(uri: uri)).toList();
    return TabBar(tabs: tabs);
  }
}
