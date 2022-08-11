import 'dart:async';

import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/repository/transformer.dart';
import 'package:feature_based_app/feature/feature_entity.dart';
import 'package:feature_based_app/feature/feature_transformer.dart';
import 'package:feature_based_app/feature/fork/fork_viewmodel.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static const emptyString = '';
}

class _Fields {
  static const variants = 'variants';
}

class ForkBusinessLogic extends ValueNotifier<ForkViewModel>
    implements Transformer<FeatureEntity, ForkViewModel, String> {
  ForkBusinessLogic(
    this.uri,
    this.repository,
  ) : super(ForkViewModel()) {
    setup();
  }

  final String uri;
  final Repository<FeatureEntity> repository;
  final featureTransformer = FeatureTransformer();

  StreamSubscription<FeatureEntity>? _subscription;

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

  Future<FeatureEntity?> refresh() async {
    try {
      final feature = await repository.single(uri);
      update(feature: feature);
      return feature;
    } catch (error) {
      _updateWithError(error);
      return null;
    }
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
    FeatureEntity? feature,
    Exception? exception,
  }) {
    if (exception != null) {
      value = ForkViewModel.error(exception, () => refresh);
    } else if (feature != null) {
      value = transform(
        feature,
        identifier: uri,
      );
    }
  }

  @override
  ForkViewModel transform(
    FeatureEntity object, {
    String? identifier,
  }) {
    final uri = identifier!;
    final variants =
        castOrNull<Map<String, dynamic>>(object.config?[_Fields.variants]) ??
            {};
    final variantFeatures = Map<String, String>.from(variants);
    return ForkViewModel(
      uri: uri,
      title: object.title ?? _Constants.emptyString,
      subtitle: object.subtitle ?? _Constants.emptyString,
      asyncStatus: AsyncInfo.complete(),
      refresh: () => refresh,
      variants: variantFeatures,
    );
  }

  @override
  FeatureEntity reverseTransform(ForkViewModel object, {String? identifier}) {
    // TODO: implement reverseTransform
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
