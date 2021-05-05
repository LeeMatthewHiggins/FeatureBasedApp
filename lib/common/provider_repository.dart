import 'package:flutter/widgets.dart';
import 'cast_utilities.dart';

// This class provides a single point to ask for a provider of a type X
// with context Y
//
// Intended Usage:
// Initialise an instance and provide a builder method,
// myProviderLibrary.providerOf<MyType>(context: myContext);
// The context is passed to the builder function and can be used to
// initialise the provider with for example a URL / ID or any other data

typedef ProviderBuilder = dynamic Function(Object?);

class ProviderRepository {
  final ProviderRepository? fallback;
  final Map<Type, Map> _providerCache = <Type, Map>{};
  final Map<Type, ProviderBuilder> _builders = <Type, ProviderBuilder>{};

  ProviderRepository({this.fallback});

  Map _providerCacheFor(Type type) {
    final typeCache = _providerCache[type];
    if (typeCache != null) {
      return typeCache;
    }
    final empty = {};
    _providerCache[type] = empty;
    return empty;
  }

  ValueNotifier<T> providerOf<T>({Object? context}) {
    var typeCache = _providerCacheFor(T);
    final cached = castOrNull<ValueNotifier<T>>(
      typeCache[context],
    );
    final provider = cached ?? _builders[T]?.call(context);
    if (provider != null) {
      typeCache[context] = provider;
      return castAssert<ValueNotifier<T>>(provider);
    }
    final fallbackProvider = fallback?.providerOf<T>(context: context);
    assert(fallbackProvider != null,
        'Could not find ProviderBuilder for type ${T.toString()}');
    return fallbackProvider!;
  }

  void registerProviderBuilder<T>(ProviderBuilder builder) {
    _builders[T] = builder;
  }

  void unregisterProviderBuilder<T>() {
    _builders.remove(T);
  }

  static final ProviderRepository global = ProviderRepository();
}

// This class provides a way to provide a different provider repository
// to all widgets beneath
class ProviderRepositoryScope extends InheritedWidget {
  final ProviderRepository repository;

  ProviderRepositoryScope({
    Key? key,
    required this.repository,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant ProviderRepositoryScope oldWidget) {
    return oldWidget.repository != repository;
  }

  static ProviderRepository? repositoryOf(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ProviderRepositoryScope>();
    return result?.repository;
  }
}
