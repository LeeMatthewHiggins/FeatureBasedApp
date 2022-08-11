import 'package:feature_based_app/common/provider_factory.dart';
import 'package:flutter/widgets.dart';

abstract class ProviderWidget<T> extends StatelessWidget {
  final Object? providerContext;

  ProviderWidget(
    this.providerContext,
  );

  @override
  Widget build(BuildContext context) {
    final provider = ProviderFactory.getProvider<T>(
      context,
      providerContext,
    );
    return ValueListenableBuilder<T>(
        valueListenable: provider,
        builder: (context, object, child) => buildWith(context, object));
  }

  Widget buildWith(BuildContext context, T object);
}

class ProviderBuilder<T> extends ProviderWidget<T> {
  final Widget Function(BuildContext context, T viewmodel) builder;

  ProviderBuilder({
    Object? viewmodelContext,
    required this.builder,
  }) : super(viewmodelContext);

  @override
  Widget buildWith(BuildContext context, T viewmodel) {
    return builder(context, viewmodel);
  }
}
