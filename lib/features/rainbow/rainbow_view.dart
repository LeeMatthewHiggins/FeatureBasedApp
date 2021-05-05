import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/features/rainbow/rainbow_viewmodel.dart';

class RainbowView extends AsyncViewModelWidget<RainbowViewModel> {
  RainbowView() : super('none');

  @override
  Widget successBuild(
    BuildContext context,
    RainbowViewModel viewmodel,
  ) {
    return Container(
      color: Color(viewmodel.hexColor),
      child: TextButton(
        onPressed: () => viewmodel.changeToColor(Random().nextInt(1<<31)),
        child: Text('Press to chance color'),
      ),
    );
  }

  @override
  Widget errorBuild(
    BuildContext context,
    RainbowViewModel viewmodel,
  ) {
    return Text(viewmodel.asyncStatus.exception.toString());
  }
}
