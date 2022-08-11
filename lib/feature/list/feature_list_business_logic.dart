import 'dart:async';

import 'package:feature_based_app/feature/feature_entity.dart';
import 'package:feature_based_app/feature/list/feature_list_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/repository/transformer.dart';
import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/feature/feature_transformer.dart';

class _Constants {
  static const emptyString = '';
}

class _Fields {
  static const subFeatures = 'subFeatures';
  static const floatingFeature = 'floatingFeature';
  static const headerType = 'header';
}

class FeatureListBusinessLogic extends ValueNotifier<FeatureListViewModel>
    implements Transformer<FeatureEntity, FeatureListViewModel, String> {
  FeatureListBusinessLogic(
    this.uri,
    this.repository,
  ) : super(FeatureListViewModel()) {
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
      return Future.error(error);
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
      value = FeatureListViewModel.error(exception, () => refresh);
    } else if (feature != null) {
      value = transform(
        feature,
        identifier: uri,
      );
    }
  }

  @override
  FeatureListViewModel transform(
    FeatureEntity object, {
    String? identifier,
  }) {
    final uri = identifier!;
    final subFeatures = castListOrNull<String>(
      object.config?[_Fields.subFeatures],
    );
    final headerType = castOrNull<String>(
      object.config?[_Fields.headerType],
    );
    final actionFeature = castOrNull<String>(
      object.config?[_Fields.floatingFeature],
    );
    return FeatureListViewModel(
        uri: uri,
        type: object.type,
        title: object.title ?? _Constants.emptyString,
        subtitle: object.subtitle ?? _Constants.emptyString,
        asyncStatus: AsyncInfo.complete(),
        refresh: () => refresh,
        subFeatures: subFeatures,
        floatingFeatureUri: actionFeature,
        headerType: headerType);
  }

  @override
  FeatureEntity reverseTransform(FeatureListViewModel object,
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
