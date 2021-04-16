import 'package:flutter/widgets.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/common/provider_library.dart';
import 'package:feature_based_app/feature/feature_widget_library.dart';

import '../app_widget_library.dart';
import 'feature_viewmodel.dart';

class FeatureResolver extends AsyncViewModelWidget<FeatureViewModel> {
  final String uri;
  late final FeatureWidgetLibrary widgetLibrary;
  FeatureResolver(
    this.uri, {
    ProviderLibrary? customLibrary,
    FeatureWidgetLibrary? customWidgetLibrary,
  }) : super(uri, customLibrary: customLibrary) {
    widgetLibrary = customWidgetLibrary ?? globalWidgetLibrary;
  }

  @override
  Widget successBuild(BuildContext context, FeatureViewModel viewmodel) {
    return widgetLibrary.widgetFor(viewmodel, context);
  }

  @override
  Widget errorBuild(BuildContext context, FeatureViewModel viewmodel) {
    return Text(viewmodel.asyncStatus.exception.toString());
  }
}
