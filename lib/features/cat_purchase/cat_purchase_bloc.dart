import 'package:riverpod/riverpod.dart';
import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/features/cat_purchase/cat_purchase_viewmodel.dart';

class _Constants {
  static const tooManyCats = 100;
}

class CatPurchaseBloc extends StateNotifier<CatPurchaseViewModel> {
  CatPurchaseBloc() : super(CatPurchaseViewModel()) {
    setup();
  }

  int _balance = 0;

  static final unknownException =
      Exception('Unknown CatPurchaseBloc Exception');

  static StateNotifierProvider<StateNotifier<CatPurchaseViewModel>> provider() {
    return StateNotifierProvider((ref) {
      return CatPurchaseBloc();
    });
  }

  void setup() async {
    _update(_balance);
  }

  void _update(int amount) {
    final tooMany = amount > _Constants.tooManyCats;

    final displayBalance =
        tooMany ? 'Thats too many cats' : 'You have $amount cats';
    state = CatPurchaseViewModel(
      asyncStatus: AsyncInfo.complete(),
      purchaseCats: _purchaseCats,
      balance: amount,
      displayBalance: displayBalance,
    );
  }

  void _purchaseCats(int amount) {
    _balance += amount;
    _update(_balance);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
