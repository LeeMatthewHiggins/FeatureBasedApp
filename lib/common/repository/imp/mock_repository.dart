import 'dart:math';

import 'package:feature_based_app/common/repository/paged.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/feature_based_app.dart';
import 'package:flutter/widgets.dart';

class MockObjects<T> {
  final int seed;
  late final Random generator;
  final List<T> library;

  MockObjects({
    this.seed = 0,
    required this.library,
  }) {
    generator = Random(seed);
  }

  T get value {
    return library[generator.nextInt(library.length)];
  }

  List<T> values({int length = 1}) {
    return List.generate(length, (index) => value);
  }
}

class MockRepository<T extends Identifiable> implements Repository<T> {
  final Future<T> Function(String uri) objectGenerator;
  final Map<String, Future<T>> _library = {};

  MockRepository(this.objectGenerator);

  @override
  Future<T> single(String uri, {T? defaultObject}) {
    final object = _library[uri] ?? objectGenerator(uri);
    _library[uri] = object;
    return object;
  }

  @override
  Future<List<T>> collection(List<String> uris) {
    return Future.wait(
      uris.map(
        (uri) => single(uri),
      ),
    );
  }

  @override
  Stream<T> stream(String uri) {
    return Stream<T>.empty();
  }

  @override
  AsyncList<T> matching({
    required Map<String, bool?> tags,
    SortType sortBy = SortType.None,
  }) {
    // TODO: implement matching
    throw UnimplementedError();
  }

  @override
  Future<T> update(String? uri, T data) {
    final id = uri ?? UniqueKey().toString();
    _library[id] = Future.value(data);
    return single(id);
  }

  @override
  Stream<List<T>> streamCollection(List<String> uris) {
    return Stream<List<T>>.empty();
  }

  @override
  Future<void> remove(String uri) async {
    await _library.remove(uri);
  }
}
