import 'package:riverpod/riverpod.dart';

import 'cast_utilities.dart';

// This class provides a single point to ask for a provider of a type T
//
// Intended Useage:
// Initialise an instance and provide a builder method,
// myProviderLibrary.providerOf<MyType>(context: myContext);
//
//
//

typedef ProviderBuilder = dynamic Function(Object?);

class ProviderLibrary {
  final Map<Type, Map> _providerCache = <Type, Map>{};
  final Map<Type, ProviderBuilder> _builders = <Type, ProviderBuilder>{};

  Map _providerCacheFor(Type type) {
    final typeCache = _providerCache[type];
    if (typeCache != null) {
      return typeCache;
    }
    final empty = {};
    _providerCache[type] = empty;
    return empty;
  }

  dynamic _build<T>(Object? context) {
    assert(_builders[T] != null,
        'Could not find ProviderBuilder for type ${T.toString()}');
    return _builders[T]!(context);
  }

  StateNotifierProvider<StateNotifier<T>> providerOf<T>({Object? context}) {
    var typeCache = _providerCacheFor(T);
    final cached =
        castOrNull<StateNotifierProvider<StateNotifier<T>>>(typeCache[context]);
    final provider = cached ?? _build<T>(context);
    typeCache[context] = provider;
    return castAssert<StateNotifierProvider<StateNotifier<T>>>(provider);
  }

  void registerProvider<T>(ProviderBuilder builder) {
    _builders[T] = builder;
  }

  void unregisterProvider<T>() {
    _builders.remove(T);
  }
}
