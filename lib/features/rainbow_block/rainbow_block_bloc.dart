import 'package:riverpod/riverpod.dart';
import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/features/rainbow_block/rainbow_block_viewmodel.dart';

class RainbowBlockBloc extends StateNotifier<RainbowBlockViewModel> {
  RainbowBlockBloc() : super(RainbowBlockViewModel()) {
    setup();
  }

  static final unknownException = Exception('Unknown FeatureBloc Exception');
  static StateNotifierProvider<StateNotifier<RainbowBlockViewModel>>
      provider() {
    return StateNotifierProvider((ref) {
      return RainbowBlockBloc();
    });
  }

  void setup() async {
    _update(0x00000000);
  }

  void _update(int color) {
    state = RainbowBlockViewModel(asyncStatus: AsyncInfo.complete(),
      changeToColor: _changeColor,
      hexColor: color,
    );
  }

  void _changeColor(int color) {
    _update(color);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
