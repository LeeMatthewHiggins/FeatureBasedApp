import 'package:feature_based_app/app_widget_factory.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';

typedef FeatureWidgetBuilder = Widget Function(
  FeatureViewModel feature,
  BuildContext context,
);

class FeatureBuilder extends AsyncViewModelWidget<FeatureViewModel> {
  final String uri;
  late final FeatureWidgetBuilder widgetBuilder;
  FeatureBuilder(
    this.uri, {
    FeatureWidgetBuilder? customWidgetBuilder,
  }) : super(
          uri,
        ) {
    widgetBuilder = customWidgetBuilder ?? globalWidgetBuilder;
  }

  @override
  Widget successBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    return widgetBuilder(
      viewmodel,
      context,
    );
  }

  @override
  Widget errorBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    return Text(
      viewmodel.asyncStatus.exception.toString(),
    );
  }
}
