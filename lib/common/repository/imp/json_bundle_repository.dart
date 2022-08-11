import 'dart:convert';

import 'package:feature_based_app/common/repository/paged.dart';
import 'package:feature_based_app/feature_based_app.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import '../transformer.dart';

class _Constants {
  static const errorLoading = 'JsonRepository failed to load';
  static const errorNotFound = 'JsonRepository failed to find entry';
}

class JsonBundleRepository<T extends Identifiable> implements Repository<T> {
  final String path;
  final String tagFieldName;
  final Transformer<Map<String, dynamic>, T, String> transformer;
  Map<String, dynamic>? _jsonMap;

  JsonBundleRepository({
    required this.path,
    required this.transformer,
    this.tagFieldName = 'tags',
  });

  Future<void> initilise() async {
    if (_jsonMap == null) {
      try {
        final jsonString = await rootBundle.loadString(path);
        final json = jsonDecode(jsonString);
        _jsonMap = castAssert<Map<String, dynamic>>(json);
      } catch (err) {
        return Future.error(
          Exception(
            _Constants.errorLoading,
          ),
        );
      }
    }
  }

  @override
  Future<T> single(String uri, {T? defaultObject}) async {
    await initilise();
    final json = _jsonMap![uri];
    if (json != null) {
      final entry = castAssert<Map<String, dynamic>>(json);
      return transformer.transform(
        entry,
        identifier: uri,
      );
    }
    return Future.error(
      Exception(
        _Constants.errorNotFound,
      ),
    );
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
    return Stream.empty();
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
    throw Exception('This repository is read only');
  }

  @override
  Stream<List<T>> streamCollection(List<String> uris) {
    return Stream<List<T>>.empty();
  }

  @override
  Future<void> remove(String uri) {
    throw Exception('This repository is read only');
  }
}
