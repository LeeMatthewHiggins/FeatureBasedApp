import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/common/object_scope.dart';
import 'package:feature_based_app/feature/list/feature_list_viewmodel.dart';
import 'package:feature_based_app/feature/route/feature_router.dart';
import 'package:feature_based_app/feature/tab/feature_bottom_navigation_bar.dart';
import 'package:feature_based_app/feature/tab/feature_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static const animationDuration = Duration(milliseconds: 300);
  static const barHeight = 101.0;
}

class FeatureBottomTabBarPage extends StatefulWidget {
  final String uri;

  const FeatureBottomTabBarPage({
    Key? key,
    required this.uri,
  }) : super(key: key);

  @override
  _FeatureBottomTabBarPageState createState() =>
      _FeatureBottomTabBarPageState();
}

class _FeatureBottomTabBarPageState extends State<FeatureBottomTabBarPage> {
  bool _barVisible = true;

  @override
  Widget build(BuildContext context) {
    return AsyncViewModelBuilder<FeatureListViewModel>(
        viewmodelContext: widget.uri,
        successBuilder: (context, viewmodel) {
          final router = Scope.of<FeatureRouter>(context)?.value;
          assert(router != null,
              'FeatureBottomTabBarPage requires a router in scope');
          final tabPage = DefaultTabController(
            length: viewmodel.subFeatures.length,
            child: Scaffold(
              bottomNavigationBar: AnimatedContainer(
                duration: _Constants.animationDuration,
                height: _barVisible ? _Constants.barHeight : 0.0,
                child: FeatureBottomNavigationBar(uri: widget.uri),
              ),
              body: NotificationListener<ScrollUpdateNotification>(
                onNotification: _scrollHandler,
                child: FeatureTabBarView(
                  uri: widget.uri,
                  swippable: false,
                  router: router,
                ),
              ),
            ),
          );
          return tabPage;
        },
        errorBuilder: (context, viewmodel) {
          throw UnimplementedError();
        });
  }

  bool _scrollHandler(ScrollUpdateNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      final drag = scrollInfo.dragDetails?.primaryDelta ?? 0.0;
      if (drag < 0) {
        if (_barVisible) {
          setState(() {
            _barVisible = false;
          });
        }
      } else if (drag > 0) {
        if (!_barVisible) {
          setState(() {
            _barVisible = true;
          });
        }
      }
    }
    return true;
  }
}
