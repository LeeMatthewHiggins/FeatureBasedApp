import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef WidgetBuilder = Widget Function(Object?);

class WidgetRepository {
  final WidgetRepository? fallback;
  WidgetBuilder? defaultBuilder;
  final Map<String, WidgetBuilder> _builders = <String, WidgetBuilder>{};

  WidgetRepository({this.fallback, this.defaultBuilder});

  Widget widgetFor({required String type, Object? context}) {
    final widget = _builders[type]?.call(context);
    if (widget != null) {
      return widget;
    }
    final fallbackProvider = fallback?.widgetFor(type: type);
    if (fallbackProvider != null) {
      return fallbackProvider;
    }
    final defaultWidget = defaultBuilder?.call(context);
    assert(
        defaultWidget != null, 'Could not find ProviderBuilder for type $type');
    return defaultWidget!;
  }

  void registerDefaultWidgetBuilder(WidgetBuilder builder){
    defaultBuilder = builder;
  }

  void registerWidgetBuilder(String type, WidgetBuilder builder) {
    _builders[type] = builder;
  }

  void unregisterProviderBuilder(String type) {
    _builders.remove(type);
  }

  static final WidgetRepository global = WidgetRepository();
}

class WidgetRepositoryScope extends InheritedWidget {
  final WidgetRepository repository;

  WidgetRepositoryScope({
    Key? key,
    required this.repository,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant WidgetRepositoryScope oldWidget) {
    return oldWidget.repository != repository;
  }

  static WidgetRepository? repositoryOf(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<WidgetRepositoryScope>();
    return result?.repository;
  }
}
