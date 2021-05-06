import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'async_viewmodel.dart';
import 'provider_repository.dart';

abstract class AsyncViewModelWidget<T extends AsyncViewModel>
    extends StatelessWidget {
  final Object viewModelContext;

  AsyncViewModelWidget(
    this.viewModelContext,
  );

  @override
  Widget build(BuildContext context) {
    final repository = ProviderRepositoryScope.repositoryOf(context) ??
        ProviderRepository.global;
    final provider = repository.providerOf<T>(context: viewModelContext);
    return ValueListenableBuilder<T>(
        valueListenable: provider,
        builder: (context, viewmodel, child) {
          switch (viewmodel.asyncStatus.asyncStatus) {
            case AsyncState.error:
              return errorBuild(context, viewmodel);
            case AsyncState.pending:
              return pendingBuild(context, viewmodel);
            default:
              return successBuild(context, viewmodel);
          }
        });
  }

  Widget successBuild(BuildContext context, T viewmodel);
  Widget errorBuild(BuildContext context, T viewmodel);
  Widget pendingBuild(BuildContext context, T viewmodel) {
    return Center(child: CircularProgressIndicator());
  }
}
