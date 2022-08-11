import 'package:feature_based_app/common/object_scope.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:flutter/widgets.dart';

typedef WidgetBuilder = Widget Function(
  FeatureEmbedType,
  FeatureViewModel?,
  Object?,
  BuildContext,
);

class WidgetFactory {
  final WidgetFactory? fallback;
  WidgetBuilder? defaultBuilder;
  final Map<String, WidgetBuilder> _builders = <String, WidgetBuilder>{};

  WidgetFactory({this.fallback, this.defaultBuilder});

  Widget widgetFor({
    required String type,
    FeatureViewModel? feature,
    required FeatureEmbedType embedType,
    Object? viewModelContext,
    required BuildContext context,
  }) {
    final widget =
        _builders[type]?.call(embedType, feature, viewModelContext, context);
    if (widget != null) {
      return widget;
    }
    final fallbackProvider = fallback?.widgetFor(
      type: type,
      feature: feature,
      embedType: embedType,
      viewModelContext: viewModelContext,
      context: context,
    );
    if (fallbackProvider != null) {
      return fallbackProvider;
    }
    final defaultWidget = defaultBuilder?.call(
      embedType,
      feature,
      viewModelContext,
      context,
    );
    assert(
        defaultWidget != null, 'Could not find WidgetBuilder for type $type');
    return defaultWidget!;
  }

  bool hasWidgetFor(String type) {
    return _builders[type] != null;
  }

  void registerDefaultWidgetBuilder(WidgetBuilder builder) {
    defaultBuilder = builder;
  }

  void registerWidgetBuilder(String type, WidgetBuilder builder) {
    _builders[type] = builder;
  }

  void unregisterProviderBuilder(String type) {
    _builders.remove(type);
  }

  static final WidgetFactory global = WidgetFactory();

  static Widget getWidget({
    required String type,
    FeatureViewModel? feature,
    required FeatureEmbedType embedType,
    Object? viewModelContext,
    required BuildContext context,
  }) {
    final factory =
        Scope.of<WidgetFactory>(context)?.value ?? WidgetFactory.global;
    return factory.widgetFor(
      type: type,
      feature: feature,
      embedType: embedType,
      viewModelContext: viewModelContext,
      context: context,
    );
  }
}
