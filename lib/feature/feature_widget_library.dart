
import 'package:flutter/material.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';

class FeatureWidgetLibrary {
  final Widget Function(FeatureViewModel feature, BuildContext context) builder;
  FeatureWidgetLibrary(this.builder);
  Widget widgetFor(FeatureViewModel feature, BuildContext context) {
    return builder(feature, context);
  }
}