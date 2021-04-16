


import 'package:flutter/material.dart';
import 'package:feature_based_app/feature/feature_list_description_page.dart';
import 'package:feature_based_app/feature/feature_widget_library.dart';
import 'package:feature_based_app/feature/feature_description_view.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:feature_based_app/features/cat_purchase/cat_purchase_view.dart';
import 'package:feature_based_app/features/rainbow_block/rainbow_view.dart';

Widget _buildWidget(FeatureViewModel feature, BuildContext context) {
  switch (feature.type) {
    case 'cats':
      return CatShopView();
    case 'rainbow':
      return RainbowView();
    case 'list':
      return FeatureListDescriptionPage(uri: feature.uri);
    default:
    return FeatureDescriptionView(feature.uri);
  }
}

final globalWidgetLibrary = FeatureWidgetLibrary(_buildWidget);