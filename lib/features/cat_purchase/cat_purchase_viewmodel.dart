import 'package:feature_based_app/common/async_viewmodel.dart';

class _Constants {
  static const defaultAmount = 1;
  static const defaultDisplay= 'Buy a cat ->';
}

typedef CatPurchaseInteraction = Function(int cats);

class CatPurchaseViewModel implements AsyncViewModel {
  final int balance;
  final String displayBalance;
  @override
  final AsyncInfo asyncStatus;
  @override
  final Function? refresh;

  late CatPurchaseInteraction purchaseCats;

  CatPurchaseViewModel({
    CatPurchaseInteraction? purchaseCats,
    this.balance = _Constants.defaultAmount,
    this.displayBalance = _Constants.defaultDisplay,
    this.asyncStatus = const AsyncInfo(),
    this.refresh,
  }) {
    this.purchaseCats = purchaseCats ?? (_){};
  }
}
