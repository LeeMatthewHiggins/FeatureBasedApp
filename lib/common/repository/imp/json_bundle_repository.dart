import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import '../transformer.dart';

class _Constants {
  static const jsonFileExtension = '.json';
  static const errorParsing = 'JsonRepository failed to parse';
  static const errorLoading = 'JsonRepository failed to load';
}

class JsonBundleRepository<T> implements Repository<T> {
  final String path;
  final Transformer<Map<String, dynamic>, T, String> transformer;

JsonBundleRepository(
    {required this.path,
    required this.transformer,}
  );

  @override
  Future<T> single(String uri) {
    final fullPath = path + uri + _Constants.jsonFileExtension;
    return rootBundle.loadString(fullPath).then((jsonString) {
      final json = jsonDecode(jsonString);
      if(json != null){
        final jsonMap = castAssert<Map<String,dynamic>>(json);
        return transformer.transform(jsonMap, identifier: uri);
      }
      return Future.error(Exception(_Constants.errorParsing));
    }, onError: (error){
      return Future.error(Exception(_Constants.errorLoading));
    });
  }

  @override
  Stream<T> stream(String uri) {
    return Stream.empty();
  }

}
