import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_provider_library.dart';
import 'async_viewmodel.dart';
import 'provider_library.dart';

abstract class AsyncViewModelWidget<T extends AsyncViewModel>
    extends ConsumerWidget {
  final Object viewmodelContext;
  late final ProviderLibrary library;
  AsyncViewModelWidget(
    this.viewmodelContext, {
    ProviderLibrary? customLibrary,
  }) {
    library = customLibrary ?? globalFeatureLibrary;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final provider = library.providerOf<T>(context: viewmodelContext);
    final viewmodel = watch(provider.state);
    switch (viewmodel.asyncStatus.asyncStatus) {
      case AsyncState.error:
        return errorBuild(context, viewmodel);
      case AsyncState.pending:
        return pendingBuild(context, viewmodel);
      default:
        return successBuild(context, viewmodel);
    }
  }

  Widget successBuild(BuildContext context, T viewmodel);
  Widget errorBuild(BuildContext context, T viewmodel);
  Widget pendingBuild(BuildContext context, T viewmodel) {
    return Center(child:CircularProgressIndicator());
  }
}
