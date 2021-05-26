import 'package:feature_based_app/common/async_viewmodel.dart';

class _Constants {
  static const unknown = '';
  static const emptyString = '';
}

class FeatureVariantViewModel implements AsyncViewModel {
  @override
  final AsyncInfo asyncStatus;
  @override
  final Function? refresh;
  final String uri;
  final String title;
  final String? subtitle;
  final Map<String, String> variants;

  factory FeatureVariantViewModel.error(Exception exception, Function refresh) {
    return FeatureVariantViewModel(
      asyncStatus: AsyncInfo.error(exception),
      refresh: refresh,
    );
  }
  
  FeatureVariantViewModel({
    this.asyncStatus = const AsyncInfo(),
    this.refresh,
    this.uri =  _Constants.unknown,
    this.title =  _Constants.emptyString,
    this.subtitle,
    this.variants = const <String, String> {},
    }
  );
}
