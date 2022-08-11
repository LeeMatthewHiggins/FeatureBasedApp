import 'package:feature_based_app/common/async_viewmodel.dart';

class _Constants {
  static const unknown = '';
  static const emptyString = '';
}

class FeatureListViewModel implements AsyncViewModel {
  @override
  final AsyncInfo asyncStatus;
  @override
  final Function? refresh;
  final String uri;
  final String type;
  final String title;
  final String subtitle;
  final List<String> subFeatures;
  final String? floatingFeatureUri;
  final String? headerType;

  factory FeatureListViewModel.error(Exception exception, Function refresh) {
    return FeatureListViewModel(
      asyncStatus: AsyncInfo.error(exception),
      refresh: refresh,
    );
  }
  const FeatureListViewModel({
    this.uri = _Constants.unknown,
    this.type = _Constants.unknown,
    this.asyncStatus = const AsyncInfo(),
    this.title = _Constants.emptyString,
    this.subtitle = _Constants.emptyString,
    this.subFeatures = const <String>[],
    this.floatingFeatureUri,
    this.headerType,
    this.refresh,
  });
}
