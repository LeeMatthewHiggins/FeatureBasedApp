import 'package:feature_based_app/common/object_scope.dart';
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

final _NoContext = 'no_context';

class ProviderFactory {
  final ProviderFactory? fallback;
  final Map<Type, Map> _providerCache = <Type, Map>{};
  final Map<Type, ProviderBuilder> _builders = <Type, ProviderBuilder>{};

  ProviderFactory({this.fallback});

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
    final cacheKey = context ?? _NoContext;
    var typeCache = _providerCacheFor(T);
    final cached = castOrNull<ValueNotifier<T>>(
      typeCache[cacheKey],
    );
    final provider = cached ?? _builders[T]?.call(context);
    if (provider != null) {
      typeCache[cacheKey] = provider;
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

  bool hasProvider<T>() {
    return _builders[T] != null;
  }

  static final ProviderFactory global = ProviderFactory();

  static ValueNotifier<T> getProvider<T>(
    BuildContext context,
    Object? objectContext,
  ) {
    final repository =
        Scope.of<ProviderFactory>(context)?.value ?? ProviderFactory.global;
    return repository.providerOf<T>(context: objectContext);
  }
}
