import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/common/provider_library.dart';
import 'package:feature_based_app/features/rainbow_block/rainbow_block_viewmodel.dart';

class RainbowView extends AsyncViewModelWidget<RainbowBlockViewModel> {
  RainbowView({
    ProviderLibrary? customLibrary,
  }) : super('none', customLibrary: customLibrary);

  @override
  Widget successBuild(
    BuildContext context,
    RainbowBlockViewModel viewmodel,
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
    RainbowBlockViewModel viewmodel,
  ) {
    return Text(viewmodel.asyncStatus.exception.toString());
  }
}
