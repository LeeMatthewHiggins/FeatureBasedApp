import 'dart:async';

import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/repository/transformer.dart';
import 'package:feature_based_app/feature/feature_model.dart';
import 'package:feature_based_app/feature/feature_transformer.dart';
import 'package:feature_based_app/features/feature_ab_test/feature_test_viewmodel.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static const emptyString = '';
}

class _Fields {
  static const variantFeatures = 'variants';
}

class FeatureTestBusinessLogic extends ValueNotifier<FeatureTestViewModel>
    implements Transformer<Feature, FeatureTestViewModel, String> {
  FeatureTestBusinessLogic(
    this.uri,
    this.repository,
  ) : super(FeatureTestViewModel()) {
    setup();
  }

  final String uri;
  final Repository<Feature> repository;
  final featureTransformer = FeatureTransformer();

  StreamSubscription<Feature>? _subscription;

  static final unknownException = Exception('Unknown FeatureBloc Exception');

  void setup() async {
    await refresh();
    await _subscription?.cancel();
    _subscription = repository.stream(uri).listen((value) {
      update(feature: value);
    }, onError: (error) {
      _updateWithError(error);
    });
  }

  Future<Feature?> refresh() {
    return repository.single(uri).then((value) {
      update(feature: value);
      return value;
    }, onError: (error) {
      _updateWithError(error);
      return null;
    });
  }

  void _updateWithError(dynamic error) {
    print(error);
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
      value = FeatureTestViewModel.error(exception, () => refresh);
    } else if (feature != null) {
      value = transform(
        feature,
        identifier: uri,
      );
    }
  }

  @override
  FeatureTestViewModel transform(
    Feature object, {
    String? identifier,
  }) {
    final uri = identifier!;
    final variants = castOrNull<Map<String, dynamic>>(
            object.config[_Fields.variantFeatures]) ??
        {};
    final variantFeatures = Map<String, String>.from(variants);
    return FeatureTestViewModel(
      uri: uri,
      title: object.title ?? _Constants.emptyString,
      subtitle: object.subtitle ?? _Constants.emptyString,
      asyncStatus: AsyncInfo.complete(),
      refresh: () => refresh,
      variants: variantFeatures,
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
