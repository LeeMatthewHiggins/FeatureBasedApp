import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/repository/transformer.dart';
import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'feature_entity.dart';
import 'feature_viewmodel.dart';

class _Constants {
  static const emptyString = '';
}

class FeatureBusinessLogic extends ValueNotifier<FeatureViewModel>
    implements Transformer<FeatureEntity, FeatureViewModel, String> {
  FeatureBusinessLogic(
    this.uri,
    this.repository,
  ) : super(FeatureViewModel()) {
    setup();
  }

  final String uri;
  final Repository<FeatureEntity> repository;
  StreamSubscription<FeatureEntity>? _subscription;

  static final unknownException = Exception('Unknown FeatureBloc Exception');

  void setup() async {
    await refresh();
  }

  Future<FeatureEntity?> refresh() async {
    await _subscription?.cancel();
    try {
      final feature = await repository.single(uri);
      update(feature: feature);
      _subscription = repository.stream(uri).listen(
        (value) {
          update(feature: value);
        },
        onError: (error) {
          _updateWithError(error);
        },
      );
      return feature;
    } catch (error) {
      _updateWithError(error);
      return null;
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
    FeatureEntity? feature,
    Exception? exception,
  }) {
    if (exception != null) {
      value = FeatureViewModel.error(exception, () => refresh);
    } else if (feature != null) {
      value = transform(
        feature,
        identifier: uri,
      );
    }
  }

  @override
  FeatureViewModel transform(FeatureEntity object, {String? identifier}) {
    assert(identifier != null, 'Feature should have a valid identifier');
    final uri = identifier!;
    final floatingFeature = castOrNull<String>(
      object.config?['floatingFeature'],
    );
    return FeatureViewModel(
      uri: uri,
      type: object.type,
      title: object.title ?? _Constants.emptyString,
      subtitle: object.subtitle ?? _Constants.emptyString,
      floatingFeatureUri: floatingFeature,
      iconUri: object.iconUri,
      config: object.config,
      asyncStatus: AsyncInfo.complete(),
      refresh: () => refresh,
    );
  }

  @override
  FeatureEntity reverseTransform(FeatureViewModel object,
      {String? identifier}) {
    // TODO: implement reverseTransform
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
