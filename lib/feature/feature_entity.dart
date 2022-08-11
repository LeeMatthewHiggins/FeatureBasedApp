import 'package:feature_based_app/feature_based_app.dart';

class FeatureEntity implements Identifiable {
  @override
  final String uri;
  final String type;
  final String? title;
  final String? subtitle;
  final String? iconUri;
  final Map<String, dynamic>? config;

  const FeatureEntity(
    this.uri,
    this.type, {
    this.iconUri,
    this.title,
    this.subtitle,
    this.config,
  });

  FeatureEntity copyWith({
    String? type,
    String? title,
    String? subtitle,
    String? iconUri,
    Map<String, dynamic>? config,
  }) {
    return FeatureEntity(
      uri,
      type ?? this.type,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      iconUri: iconUri ?? this.iconUri,
      config: config ?? this.config,
    );
  }
}
