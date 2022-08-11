import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/feature/rainbow/rainbow_viewmodel.dart';
import 'package:flutter/widgets.dart';

class RainbowBusinessLogic extends ValueNotifier<RainbowViewModel> {
  RainbowBusinessLogic() : super(RainbowViewModel()) {
    setup();
  }

  static final unknownException = Exception('Unknown FeatureBloc Exception');

  void setup() async {
    _update(0x00000000);
  }

  void _update(int color) {
    value = RainbowViewModel(
      asyncStatus: AsyncInfo.complete(),
      changeToColor: _changeColor,
      hexColor: color,
    );
  }

  void _changeColor(int color) {
    _update(color);
  }
}
