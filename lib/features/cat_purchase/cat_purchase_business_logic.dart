
import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/features/cat_purchase/cat_purchase_viewmodel.dart';
import 'package:flutter/foundation.dart';

class _Constants {
  static const tooManyCats = 100;
}

class CatPurchaseBusinessLogic extends ValueNotifier<CatPurchaseViewModel> {
  CatPurchaseBusinessLogic() : super(CatPurchaseViewModel()) {
    setup();
  }

  int _balance = 0;

  static final unknownException =
      Exception('Unknown CatPurchaseBloc Exception');

  void setup() async {
    _update(_balance);
  }

  void _update(int amount) {
    final tooMany = amount > _Constants.tooManyCats;

    final displayBalance =
        tooMany ? 'Thats too many cats' : 'You have $amount cats';
    value = CatPurchaseViewModel(
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

}
