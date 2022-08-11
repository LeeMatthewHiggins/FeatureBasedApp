import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/common/object_scope.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/feature_description_view.dart';
import 'package:feature_based_app/feature/list/feature_list_viewmodel.dart';
import 'package:feature_based_app/feature/route/feature_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeatureListMenu extends AsyncViewModelWidget<FeatureListViewModel> {
  final String uri;
  late final FeatureWidgetBuilder widgetBuilder;

  FeatureListMenu({required this.uri}) : super(uri);

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
    final router = Scope.of<FeatureRouter>(context)?.value;
    return ListView.builder(
        itemCount: viewmodel.subFeatures.length,
        itemBuilder: (context, index) {
          final uri = viewmodel.subFeatures[index];
          return FeatureDescriptionView(
            uri: viewmodel.subFeatures[index],
            onTap: () {
              router!.pushFeatureWithUri(buildContext: context, uri: uri);
            },
          );
        });
  }

  @override
  Widget pendingBuild(
    BuildContext context,
    FeatureListViewModel viewmodel,
  ) {
    return Center(child: CircularProgressIndicator());
  }
}
