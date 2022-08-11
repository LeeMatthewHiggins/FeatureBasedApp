import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/common/widget_factory.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:flutter/material.dart';

class FeatureTab extends AsyncViewModelWidget<FeatureViewModel> {
  static const iconTypeName = 'FeatureTabIcon';
  final String uri;
  final bool hideTitle;

  FeatureTab({required this.uri, this.hideTitle = false}) : super(uri);

  @override
  Widget errorBuild(BuildContext context, FeatureViewModel viewmodel) {
    // TODO: implement errorBuild
    throw UnimplementedError();
  }

  @override
  Widget successBuild(BuildContext context, FeatureViewModel viewmodel) {
    late final Widget? icon;
    if (viewmodel.iconUri != null) {
      icon = WidgetFactory.getWidget(
        type: iconTypeName,
        embedType: FeatureEmbedType.view,
        viewModelContext: viewmodel.iconUri,
        context: context,
      );
    } else {
      icon = null;
    }
    final text = (hideTitle && icon != null) ? null : viewmodel.title;
    return Tab(
      icon: icon,
      text: text,
      iconMargin: EdgeInsets.zero,
    );
  }
}
