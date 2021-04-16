class Feature {
  final String uri;
  final String type;
  final String? title;
  final String? subtitle;
  final Map<String, dynamic> config;

  const Feature(
    this.uri,
    this.type, {
    this.title,
    this.subtitle,
    this.config = const <String,dynamic>{},
  });
}
