import 'package:flutter/widgets.dart';

class Scope<T> extends InheritedWidget {
  final T value;

  Scope({
    Key? key,
    required this.value,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(covariant Scope<T> oldWidget) {
    return oldWidget.value != value;
  }

  static Scope<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Scope<T>>();
  }

  static T? valueOf<T>(BuildContext context, {T? defaultValue}) {
    return context.dependOnInheritedWidgetOfExactType<Scope<T>>()?.value ??
        defaultValue;
  }
}
