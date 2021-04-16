import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:feature_based_app/common/repository/repository.dart';
import 'package:feature_based_app/common/repository/transformer.dart';
import 'package:feature_based_app/common/async_viewmodel.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/feature/feature_transformer.dart';
import 'feature_list_viewmodel.dart';
import 'feature_model.dart';

class _Constants {
  static const emptyString = '';
}

class _Fields {
  static const subFeatures = 'subFeatures';
}

class FeatureListBloc extends StateNotifier<FeatureListViewModel>
    implements Transformer<Feature, FeatureListViewModel, String> {
  FeatureListBloc(
    this.uri,
    this.repository,
  ) : super(FeatureListViewModel()) {
    setup();
  }

  final String uri;
  final Repository<Feature> repository;
  final featureTransformer = FeatureTransformer();

  StreamSubscription<Feature>? _subscription;

  static final unknownException = Exception('Unknown FeatureBloc Exception');
  static StateNotifierProvider<StateNotifier<FeatureListViewModel>> provider(
    String uri,
    Repository<Feature> repo,
  ) {
    return StateNotifierProvider((ref) {
      return FeatureListBloc(
        uri,
        repo,
      );
    });
  }

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
      state = FeatureListViewModel.error(exception, () => refresh);
    } else if (feature != null) {
      state = transform(
        feature,
        identifier: uri,
      );
    }
  }

  @override
  FeatureListViewModel transform(Feature object, {String? identifier}) {
    final uri = identifier!;
    final subFeatures = castListOrNull<String>(
      object.config[_Fields.subFeatures],
    );
    return FeatureListViewModel(
        uri: uri,
        type: object.type,
        title: object.title ?? _Constants.emptyString,
        subtitle: object.subtitle ?? _Constants.emptyString,
        asyncStatus: AsyncInfo.complete(),
        refresh: () => refresh,
        subFeatures: subFeatures);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
