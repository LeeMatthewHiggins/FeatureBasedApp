import 'package:feature_based_app/common/async_viewmodel.dart';

class _Constants {
  static const unknown = '';
  static const emptyString = '';
}

class FeatureViewModel implements AsyncViewModel {
  @override
  final AsyncInfo asyncStatus;
  @override
  final Function? refresh;
  final String uri;
  final String type;
  final String title;
  final String subtitle;
  

  const FeatureViewModel({
    this.uri = _Constants.unknown,
    this.type = _Constants.unknown,
    this.asyncStatus = const AsyncInfo(),
    this.title = _Constants.emptyString,
    this.subtitle = _Constants.emptyString,
    this.refresh,
  });

  factory FeatureViewModel.error(Exception exception, Function refresh) {
    return FeatureViewModel(
      asyncStatus: AsyncInfo.error(exception),
      refresh: refresh,
    );
  }
}
