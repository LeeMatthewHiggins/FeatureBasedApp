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
    if(object is T){
      return object as T;
    }
  }
  return null;
}

T castOrDefault<T>(Object? object, {required T defaultObject}) {
  if (object != null) {
    if(object is T){
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
  return list.map((item) {
    return castOrNull<T>(item);
  }).whereType<T>().toList();
}
