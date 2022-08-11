import 'dart:async';

import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/repository/transformer.dart';
import 'package:feature_based_app/feature_based_app.dart';
import 'package:flutter/foundation.dart';

class SingleAsyncViewmodelProvider<E extends Identifiable,
    V extends AsyncViewModel> extends ValueNotifier<V> {
  SingleAsyncViewmodelProvider({
    required this.uri,
    required this.transformer,
    required this.repository,
    required V initailViewmodel,
  }) : super(initailViewmodel) {
    setup();
  }

  final String uri;
  final Transformer<E, V, String> transformer;
  final Repository<E> repository;

  StreamSubscription<E>? _subscription;

  static final unknownException =
      Exception('Unknown SingleAsyncViewmodelProvider Exception');

  void setup() async {
    await refresh();
  }

  Future<void> refresh() async {
    await _subscription?.cancel();
    try {
      final entity = await repository.single(uri);
      update(entity: entity);
      _subscription = repository.stream(uri).listen((value) {
        update(entity: value);
      }, onError: (error) {
        _updateWithError(error);
      });
    } catch (error) {
      _updateWithError(error);
      return Future.error(error);
    }
  }

  void _updateWithError(dynamic error) {
    update(
      exception: castOrDefault<Exception>(
        error,
        defaultObject: unknownException,
      ),
    );
  }

  void update({
    E? entity,
    Exception? exception,
  }) async {
    if (exception != null) {
      // TODO: solve error condition
    } else if (entity != null) {
      value = transformer.transform(
        entity,
        identifier: entity.uri,
      );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
