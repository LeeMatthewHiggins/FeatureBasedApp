import 'package:feature_based_app/common/widget_repository.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';

typedef FeatureWidgetBuilder = Widget Function(
  FeatureViewModel feature,
  BuildContext context,
);

class FeatureBuilder extends AsyncViewModelWidget<FeatureViewModel> {
  final String uri;
  FeatureBuilder(this.uri)
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
    return widgetRepository.widgetFor(
      type: viewmodel.type,
      context: viewmodel.uri,
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
