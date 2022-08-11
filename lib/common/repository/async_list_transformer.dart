import 'dart:async';

import 'package:feature_based_app/common/repository/identifiable.dart';
import 'package:feature_based_app/common/repository/paged.dart';
import 'package:feature_based_app/common/repository/transformer.dart';

class AsyncListTransformer<F extends Identifiable, T> implements AsyncList<T> {
  final AsyncList<F> source;
  final Transformer<F, T, String> transformer;

  AsyncListTransformer({
    required this.source,
    required this.transformer,
  });
  @override
  Future<void> firstPage() {
    return source.firstPage();
  }

  @override
  bool hasNextPage() {
    return source.hasNextPage();
  }

  @override
  bool hasPrevPage() {
    return source.hasPrevPage();
  }

  @override
  Future<void> nextPage() {
    return source.nextPage();
  }

  @override
  Future<void> prevPage() {
    return source.prevPage();
  }

  @override
  List<T> get single => source.single
      .map(
        (item) => transformer.transform(item, identifier: item.uri),
      )
      .toList();

  @override
  Stream<List<T>> get stream => source.stream
          .transform<List<T>>(StreamTransformer.fromHandlers(handleData: (
        List<F> snap,
        EventSink<List<T>> sink,
      ) {
        sink.add(
          snap
              .map(
                (item) => transformer.transform(item, identifier: item.uri),
              )
              .toList(),
        );
      }));
}
