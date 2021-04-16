import 'package:feature_based_app/common/repository/transformer.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/feature/feature_model.dart';


class _Constants {
  static const title = 'title';
  static const subtitle = 'subtitle';
  static const type = 'type';
  static const config = 'config';
}

class FeatureTransformer
    implements Transformer<Map<String, dynamic>, Feature, String> {
  @override
  Feature transform(Map<String, dynamic> data, {String? identifier}) {
    final uri = castAssert<String>(identifier);
    return Feature(
      uri,
      castAssert<String>(data[_Constants.type]),
      title: castOrNull<String>(data[_Constants.title]),
      subtitle: castOrNull<String>(data[_Constants.subtitle]),
      config: castOrDefault<Map<String, dynamic>>(
        data[_Constants.config],
        defaultObject: <String, dynamic>{},
      ),
    );
  }
}
