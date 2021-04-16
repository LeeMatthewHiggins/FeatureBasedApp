import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feature_based_app/app_provider_library.dart';
import 'package:feature_based_app/common/cast_utilities.dart';
import 'package:feature_based_app/feature/feature_bloc.dart';
import 'package:feature_based_app/feature/feature_list_bloc.dart';
import 'package:feature_based_app/feature/feature_list_viewmodel.dart';
import 'package:feature_based_app/feature/feature_resolver.dart';
import 'package:feature_based_app/feature/feature_viewmodel.dart';
import 'package:feature_based_app/features/cat_purchase/cat_purchase_bloc.dart';
import 'package:feature_based_app/features/cat_purchase/cat_purchase_viewmodel.dart';
import 'package:feature_based_app/features/rainbow_block/rainbow_block_bloc.dart';
import 'package:feature_based_app/features/rainbow_block/rainbow_block_viewmodel.dart';

final rootFeatureUri = 'features/faywVslr8RLHEN72JOXw';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerGlobalProviders();
  runApp(ProviderScope(child: MyApp()));
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
              home: FeatureResolver(rootFeatureUri),
            );
  }
}

void registerGlobalProviders() {
  globalFeatureLibrary.registerProvider<FeatureViewModel>((Object? context) {
    final uri = castAssert<String>(context);
    return FeatureBloc.provider(
      uri,
      jsonFeatureRepo,
    );
  });

  globalFeatureLibrary
      .registerProvider<FeatureListViewModel>((Object? context) {
    final uri = castAssert<String>(context);
    return FeatureListBloc.provider(
      uri,
      jsonFeatureRepo,
    );
  });

  globalFeatureLibrary
      .registerProvider<RainbowBlockViewModel>((Object? context) {
    return RainbowBlockBloc.provider();
  });

  globalFeatureLibrary
      .registerProvider<CatPurchaseViewModel>((Object? context) {
    return CatPurchaseBloc.provider();
  });
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

