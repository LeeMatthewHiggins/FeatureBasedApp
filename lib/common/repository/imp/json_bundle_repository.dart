import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import '../transformer.dart';

class _Constants {
  static const errorLoading = 'JsonRepository failed to load';
  static const errorNotFound = 'JsonRepository failed to find entry';
}

class JsonBundleRepository<T> implements Repository<T> {
  final String path;
  final Transformer<Map<String, dynamic>, T, String> transformer;
  Map<String, dynamic>? _jsonMap;

  JsonBundleRepository({
    required this.path,
    required this.transformer,
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
  Future<T> single(String uri) async {
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
  Stream<T> stream(String uri) {
    return Stream.empty();
  }
}
