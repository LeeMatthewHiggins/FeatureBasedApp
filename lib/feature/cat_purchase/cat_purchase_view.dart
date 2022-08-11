import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/feature/cat_purchase/cat_purchase_viewmodel.dart';

class CatShopView extends AsyncViewModelWidget<CatPurchaseViewModel> {
  CatShopView() : super('none');

  @override
  Widget successBuild(
    BuildContext context,
    CatPurchaseViewModel viewmodel,
  ) {
    return ListTile(
      leading: Icon(Icons.adb_sharp),
      title: Text(viewmodel.displayBalance),
      trailing: TextButton(
        onPressed: () => viewmodel.purchaseCats(1),
        child: Text('Buy a cat now'),
      ),
    );
  }

  @override
  Widget errorBuild(
    BuildContext context,
    CatPurchaseViewModel viewmodel,
  ) {
    return Text(viewmodel.asyncStatus.exception.toString());
  }
}
