import 'package:feature_based_app/common/widget_factory.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:feature_based_app/common/async_viewmodel_widget.dart';

enum FeatureEmbedType { page, sliver, view }

typedef FeatureWidgetBuilder = Widget Function(
  FeatureViewModel feature,
  BuildContext context,
);

abstract class FeatureWidgetFactory {
  Widget page(
    FeatureViewModel? featureURI,
    Object? viewModelContext,
    BuildContext context,
  );
  Widget sliver(
    FeatureViewModel? featureURI,
    Object? viewModelContext,
    BuildContext context,
  );
  Widget view(
    FeatureViewModel? featureURI,
    Object? viewModelContext,
    BuildContext context,
  );

  Widget builder(
    FeatureEmbedType type,
    FeatureViewModel? feature,
    Object? viewModelContext,
    BuildContext context,
  ) {
    switch (type) {
      case FeatureEmbedType.page:
        return page(
          feature,
          viewModelContext,
          context,
        );
      case FeatureEmbedType.sliver:
        return sliver(
          feature,
          viewModelContext,
          context,
        );
      case FeatureEmbedType.view:
        return view(
          feature,
          viewModelContext,
          context,
        );
    }
  }
}

class FeatureBuilder extends AsyncViewModelWidget<FeatureViewModel> {
  final String uri;
  final FeatureEmbedType embedType;
  final String? typeOverride;
  final Object? featureContext;
  FeatureBuilder({
    required this.uri,
    this.embedType = FeatureEmbedType.view,
    this.typeOverride,
    this.featureContext,
  }) : super(
          uri,
        );

  @override
  Widget successBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    return WidgetFactory.getWidget(
      feature: viewmodel,
      type: typeOverride ?? viewmodel.type,
      embedType: embedType,
      viewModelContext: featureContext,
      context: context,
    );
  }

  @override
  Widget errorBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    final message = Text(
      viewmodel.asyncStatus.exception.toString(),
    );
    switch (embedType) {
      case FeatureEmbedType.sliver:
        return SliverToBoxAdapter(
          child: message,
        );
      case FeatureEmbedType.view:
        return message;
      default:
        return Scaffold(
          body: message,
        );
    }
  }

  @override
  Widget pendingBuild(
    BuildContext context,
    FeatureViewModel viewmodel,
  ) {
    final pending = Center(child: CircularProgressIndicator());
    switch (embedType) {
      case FeatureEmbedType.sliver:
        return SliverToBoxAdapter(
          child: pending,
        );
      case FeatureEmbedType.view:
        return pending;
      default:
        return Scaffold(
          body: pending,
        );
    }
  }
}
