import 'package:feature_based_app/common/object_scope.dart';
import 'package:feature_based_app/common/popup_container.dart';
import 'package:feature_based_app/common/widget_factory.dart';
import 'package:feature_based_app/feature/feature_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static const featureUri = 'featureUri';
  static const featureContext = 'featureContext';
}

class FeatureRouter {
  static const featureRouteName = '/feature';

  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {};

  PageRoute onGenerateRoute(RouteSettings settings,
      {FeatureEmbedType embedType = FeatureEmbedType.page}) {
    if (settings.name == featureRouteName) {
      final args = settings.arguments as Map<String, dynamic>;
      final featureUri = args[_Constants.featureUri] as String;
      final featureContext = args[_Constants.featureContext];
      return MaterialPageRoute(
        builder: (context) => Scope<FeatureRouter>(
          value: this,
          child: FeatureBuilder(
            uri: featureUri,
            embedType: embedType,
            featureContext: featureContext,
          ),
        ),
      );
    }
    return MaterialPageRoute(builder: (context) {
      return WidgetFactory.getWidget(
          type: settings.name!,
          embedType: embedType,
          viewModelContext: settings.arguments,
          context: context);
    });
  }

  void pushFeatureWithUri({
    required BuildContext buildContext,
    required String uri,
    Object? viewModelContext,
    bool useRootNavigator = false,
  }) {
    Navigator.of(
      buildContext,
      rootNavigator: useRootNavigator,
    ).pushNamed(
      featureRouteName,
      arguments: {
        _Constants.featureUri: uri,
        _Constants.featureContext: viewModelContext,
      },
    );
  }

  void pushFeature({
    required BuildContext buildContext,
    required String name,
    Object? viewModelContext,
    bool useRootNavigator = false,
  }) {
    Navigator.of(
      buildContext,
      rootNavigator: useRootNavigator,
    ).pushNamed(
      name,
      arguments: viewModelContext,
    );
  }

  void popupFeature({
    required BuildContext buildContext,
    required String name,
    Object? viewModelContext,
    bool useRootNavigator = false,
  }) {
    final featureWidget = WidgetFactory.getWidget(
        type: name,
        embedType: FeatureEmbedType.page,
        viewModelContext: viewModelContext,
        context: buildContext);
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      useRootNavigator: useRootNavigator,
      context: buildContext,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => Scope<FeatureRouter>(
        value: this,
        child: PopupContainer(child: featureWidget),
      ),
    );
  }

  void popupFeatureWithUri({
    required BuildContext buildContext,
    required String uri,
    Object? viewModelContext,
    FeatureEmbedType embedType = FeatureEmbedType.page,
    bool useRootNavigator = false,
  }) {
    final featureWidget = FeatureBuilder(
      uri: uri,
      embedType: embedType,
      featureContext: viewModelContext,
    );
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      useRootNavigator: useRootNavigator,
      context: buildContext,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => Scope<FeatureRouter>(
        value: this,
        child: PopupContainer(child: featureWidget),
      ),
    );
  }

  bool pop(String featureUri) {
    final navigatorState = _navigatorKeys[featureUri]?.currentState;
    final canPop = navigatorState?.canPop() ?? false;
    if (canPop) {
      navigatorState?.pop();
    }
    return canPop;
  }

  void popToRoot(String featureUri) {
    final navigatorState = _navigatorKeys[featureUri]?.currentState;
    navigatorState?.popUntil((route) => route.isFirst);
  }

  Widget persistantNavigationContainer(String featureUri,
      {FeatureEmbedType embedType = FeatureEmbedType.page}) {
    return _PageContainer(
      child: ClipRect(
        child: Navigator(
          initialRoute: featureRouteName,
          onGenerateRoute: onGenerateRoute,
          onGenerateInitialRoutes: (
            NavigatorState navigator,
            String initialRouteName,
          ) {
            return [
              onGenerateRoute(
                RouteSettings(
                  name: featureRouteName,
                  arguments: {'featureUri': featureUri},
                ),
                embedType: embedType,
              ),
            ];
          },
          key: _getNavigatorKeyFor(featureUri),
        ),
      ),
    );
  }

  GlobalKey<NavigatorState> _getNavigatorKeyFor(String id) {
    var state = _navigatorKeys[id];
    if (state == null) {
      state = GlobalKey<NavigatorState>();
      _navigatorKeys[id] = state;
    }
    return state;
  }
}

class _PageContainer extends StatefulWidget {
  final Widget child;
  const _PageContainer({Key? key, required this.child}) : super(key: key);

  @override
  __PageContainerState createState() => __PageContainerState();
}

class __PageContainerState extends State<_PageContainer>
    with AutomaticKeepAliveClientMixin<_PageContainer> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
