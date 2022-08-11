T castAssert<T>(Object? object) {
  assert(object != null, 'Null object passed');
  final castObject = object as T;
  assert(
    castObject != null,
    'Unable to cast ' + object.runtimeType.toString() + ' -> ' + T.toString(),
  );
  return castObject;
}

T? castOrNull<T>(Object? object) {
  if (object != null) {
    if (object is T) {
      return object as T;
    }
  }
  return null;
}

T castOrDefault<T>(Object? object, {required T defaultObject}) {
  if (object != null) {
    if (object is T) {
      return object as T;
    }
    return defaultObject;
  }
  return defaultObject;
}

List<T> castListOrNull<T>(dynamic from) {
  final list = castOrNull<List<dynamic>>(from);
  if (list == null) {
    return <T>[];
  }
  return list
      .map((item) {
        return castOrNull<T>(item);
      })
      .whereType<T>()
      .toList();
}

Map<String, T> castMapOrNull<T>(dynamic from) {
  final map = castOrNull<Map<String, dynamic>>(from);
  if (map == null) {
    return <String, T>{};
  }
  var result = <String, T>{};
  for (var entry in map.entries) {
    if (entry.value is T) {
      result[entry.key] = entry.value as T;
    }
  }
  return result;
}

List<T> castListOrDefault<T>(dynamic from, T defaultObject) {
  final list = castOrNull<List<dynamic>>(from);
  if (list == null) {
    return [];
  }
  return list.map<T>((item) {
    return castOrDefault<T>(item, defaultObject: defaultObject);
  }).where((item) {
    return (item != null);
  }).toList();
}

num castAssertNumber(dynamic from) {
  final number = castOrNull<int>(from)?.toDouble() ?? castOrNull<double>(from);
  assert(
      number != null,
      'Unable to cast ' +
          from.runtimeType.toString() +
          ' ->  number(int / double)');
  return number!;
}

num? castNumber(dynamic from) {
  return castOrNull<int>(from)?.toDouble() ?? castOrNull<double>(from);
}

num castNumberOrDefault<T extends num>(dynamic from, T defaultNumber) {
  return (castOrNull<int>(from)?.toDouble() ?? castOrNull<double>(from)) ??
      defaultNumber;
}
