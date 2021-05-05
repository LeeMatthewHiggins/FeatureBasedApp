import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'feature_viewmodel.dart';

class FeatureDescriptionView extends AsyncViewModelWidget<FeatureViewModel> {
  final String uri;
  FeatureDescriptionView(this.uri)
      : super(
          uri,
        );

  @override
  Widget successBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    return ListTile(
      leading: Align(
        widthFactor: 1.0,
        child: Text(viewmodel.type),
      ),
      title: Text(viewmodel.title),
      subtitle: Text(viewmodel.subtitle),
    );
  }

  @override
  Widget errorBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    return Text(viewmodel.asyncStatus.exception.toString());
  }
}
