import 'package:feature_based_app/common/object_scope.dart';
import 'package:feature_based_app/common/repository/imp/json_bundle_repository.dart';
import 'package:feature_based_app/feature/feature_transformer.dart';
import 'package:feature_based_app/feature/route/feature_router.dart';
import 'package:feature_based_app/features.dart';
import 'package:flutter/material.dart';
import 'package:feature_based_app/feature/feature_builder.dart';

final rootFeatureUri = 'features/000001';

final jsonFeatureRepo = JsonBundleRepository(
  path: 'assets/config/features/featureRepository.json',
  transformer: FeatureTransformer(),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerFeatureBasedBuildingBlocks(jsonFeatureRepo);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scope<FeatureRouter>(
      value: FeatureRouter(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: FeatureBuilder(
          uri: rootFeatureUri,
          embedType: FeatureEmbedType.page,
        ),
      ),
    );
  }
}

/*class MyFilebaseApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ' + snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme: TextTheme(),
                primarySwatch: Colors.blue,
              ),
              home: FeatureResolver(rootFeatureUri),
            );
          }
          return CircularProgressIndicator();
        });
  }
}*/
