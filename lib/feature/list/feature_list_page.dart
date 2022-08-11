import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/common/object_scope.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/list/feature_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeatureListPage extends AsyncViewModelWidget<FeatureListViewModel> {
  final String uri;
  FeatureListPage({
    required this.uri,
  }) : super(uri);

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
        .map((feature) => FeatureBuilder(
              uri: feature,
              embedType: FeatureEmbedType.sliver,
            ))
        .toList();

    final headerWidgets = (viewmodel.headerType != null)
        ? viewmodel.subFeatures
            .map((feature) => FeatureBuilder(
                  uri: feature,
                  embedType: FeatureEmbedType.sliver,
                  typeOverride: viewmodel.headerType,
                ))
            .toList()
        : <Widget>[];

    var combinedWidgets = <Widget>[];

    for (var _ in viewmodel.subFeatures) {
      final header =
          headerWidgets.isNotEmpty ? [headerWidgets.removeAt(0)] : <Widget>[];
      final body =
          featureWidgets.isNotEmpty ? [featureWidgets.removeAt(0)] : <Widget>[];
      combinedWidgets += [
        ...header,
        ...body,
      ];
    }

    final actionFeature = viewmodel.floatingFeatureUri != null
        ? FeatureBuilder(
            uri: viewmodel.floatingFeatureUri!,
            embedType: FeatureEmbedType.view,
          )
        : null;
    final scrollController =
        Scope.valueOf<ScrollController>(context) ?? ScrollController();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: actionFeature,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverSafeArea(
            sliver: SliverToBoxAdapter(
              child: Container(),
            ),
          ),
          ...combinedWidgets,
        ],
      ),
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
