import 'package:feature_based_app/common/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'async_viewmodel.dart';

abstract class AsyncViewModelWidget<T extends AsyncViewModel>
    extends ProviderWidget<T> {
  AsyncViewModelWidget(
    dynamic viewModelContext,
  ) : super(viewModelContext);

  @override
  Widget buildWith(BuildContext context, T viewmodel) {
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
    return Center(child: CircularProgressIndicator());
  }
}

class AsyncViewModelBuilder<T extends AsyncViewModel>
    extends AsyncViewModelWidget<T> {
  final Widget Function(BuildContext context, T viewmodel) successBuilder;
  final Widget Function(BuildContext context, T viewmodel) errorBuilder;
  final Widget Function(BuildContext context, T viewmodel)? pendingBuilder;

  AsyncViewModelBuilder({
    Object? viewmodelContext,
    required this.successBuilder,
    required this.errorBuilder,
    this.pendingBuilder,
  }) : super(viewmodelContext);

  @override
  Widget errorBuild(BuildContext context, T viewmodel) {
    return errorBuilder(context, viewmodel);
  }

  @override
  Widget pendingBuild(BuildContext context, T viewmodel) {
    return pendingBuilder?.call(context, viewmodel) ??
        super.pendingBuild(context, viewmodel);
  }

  @override
  Widget successBuild(BuildContext context, T viewmodel) {
    return successBuilder(context, viewmodel);
  }
}
