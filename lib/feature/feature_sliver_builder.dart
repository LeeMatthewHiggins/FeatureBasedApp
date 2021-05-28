import 'package:feature_based_app/common/widget_repository.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:feature_based_app/features/list/feature_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';


class FeatureSliverBuilder extends AsyncViewModelWidget<FeatureViewModel> {
  final String uri;
  FeatureSliverBuilder(this.uri)
      : super(
          uri,
        );

  @override
  Widget successBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    final widgetRepository =
        WidgetRepositoryScope.repositoryOf(context) ?? WidgetRepository.global;
    final widget = widgetRepository.widgetFor(
      type: viewmodel.type,
      context: viewmodel.uri,
    );
    if(widget is FeatureSliverList) {
      return widget;
    }
    return SliverToBoxAdapter(child:widget);
  }

  @override
  Widget errorBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    return SliverToBoxAdapter(child:Text(
      viewmodel.asyncStatus.exception.toString(),
    ));
  }

  @override
  Widget pendingBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    return SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()));
  }
}
