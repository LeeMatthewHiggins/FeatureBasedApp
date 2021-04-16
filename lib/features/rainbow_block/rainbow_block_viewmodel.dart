import 'package:feature_based_app/common/async_viewmodel.dart';

class _Constants {
  static const transparent = 0x00000000;
}

typedef ColorInteraction = Function(int color);

class RainbowBlockViewModel implements AsyncViewModel {
  final int hexColor;
  @override
  final AsyncInfo asyncStatus;
  @override
  final Function? refresh;

  late Function(int color) changeToColor;

  RainbowBlockViewModel({
    ColorInteraction? changeToColor,
    this.hexColor = _Constants.transparent,
    this.asyncStatus = const AsyncInfo(),
    this.refresh,
  }) {
    this.changeToColor = changeToColor ?? (_){};
  }
}
