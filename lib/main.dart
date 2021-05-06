import 'package:feature_based_app/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feature_based_app/global_providers.dart';
import 'package:feature_based_app/feature/feature_builder.dart';

final rootFeatureUri = 'features/faywVslr8RLHEN72JOXw';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerGlobalProviders();
  registerGlobalWidgets();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: FeatureBuilder(rootFeatureUri),
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
