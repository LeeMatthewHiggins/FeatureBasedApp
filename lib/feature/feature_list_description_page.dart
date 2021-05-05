import 'package:flutter/material.dart';
import 'package:feature_based_app/feature/feature_description_view.dart';
import 'package:feature_based_app/features/list/feature_sliver_list.dart';

class FeatureListDescriptionPage extends StatelessWidget {
  final String uri;
  const FeatureListDescriptionPage({
    Key? key,
    required this.uri,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: FeatureDescriptionView(uri),
          ),
          FeatureSliverList(uri),
        ],
      ),
    );
  }
}
