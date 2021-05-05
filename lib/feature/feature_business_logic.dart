import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/repository/transformer.dart';
import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'feature_model.dart';
import 'feature_viewmodel.dart';

class _Constants {
  static const emptyString = '';
}

class FeatureBusinessLogic extends ValueNotifier<FeatureViewModel>
    implements Transformer<Feature, FeatureViewModel, String> {
  FeatureBusinessLogic(
    this.uri,
    this.repository,
  ) : super(FeatureViewModel()) {
    setup();
  }

  final String uri;
  final Repository<Feature> repository;
  StreamSubscription<Feature>? _subscription;

  static final unknownException = Exception('Unknown FeatureBloc Exception');

  void setup() async {
    await refresh();
    await _subscription?.cancel();
    _subscription = repository.stream(uri).listen(
      (value) {
        update(feature: value);
      },
      onError: (error) {
        _updateWithError(error);
      },
    );
  }

  Future<Feature?> refresh() {
    return repository.single(uri).then(
      (value) {
        update(feature: value);
        return value;
      },
      onError: (error) {
        _updateWithError(error);
        return null;
      },
    );
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
    Feature? feature,
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
  FeatureViewModel transform(Feature object, {String? identifier}) {
    assert(identifier != null, 'Feature should have a valid identifier');
    final uri = identifier!;
    return FeatureViewModel(
      uri: uri,
      type: object.type,
      title: object.title ?? _Constants.emptyString,
      subtitle: object.subtitle ?? _Constants.emptyString,
      asyncStatus: AsyncInfo.complete(),
      refresh: () => refresh,
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
