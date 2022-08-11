import 'package:feature_based_app/common/repository/transformer.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/feature/feature_entity.dart';

class _Constants {
  static const title = 'title';
  static const subtitle = 'subtitle';
  static const type = 'type';
  static const iconUri = 'iconUri';
  static const config = 'config';
}

class FeatureTransformer
    implements Transformer<Map<String, dynamic>, FeatureEntity, String> {
  const FeatureTransformer();
  @override
  FeatureEntity transform(
    Map<String, dynamic> data, {
    String? identifier,
  }) {
    final uri = castAssert<String>(identifier);
    return FeatureEntity(
      uri,
      castAssert<String>(data[_Constants.type]),
      title: castOrNull<String>(data[_Constants.title]),
      subtitle: castOrNull<String>(data[_Constants.subtitle]),
      iconUri: castOrNull<String>(data[_Constants.iconUri]),
      config: castOrNull<Map<String, dynamic>>(
        data[_Constants.config],
      ),
    );
  }

  @override
  Map<String, dynamic> reverseTransform(FeatureEntity object,
      {String? identifier}) {
    // TODO: implement reverseTransform
    throw UnimplementedError();
  }
}
