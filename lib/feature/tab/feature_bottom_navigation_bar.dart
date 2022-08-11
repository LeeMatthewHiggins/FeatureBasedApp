import 'package:feature_based_app/common/async_viewmodel_widget.dart';
import 'package:feature_based_app/common/object_scope.dart';
import 'package:feature_based_app/feature/list/feature_list_viewmodel.dart';
import 'package:feature_based_app/feature/route/feature_router.dart';
import 'package:feature_based_app/feature/tab/feature_tab.dart';
import 'package:flutter/material.dart';

class FeatureBottomNavigationBar
    extends AsyncViewModelWidget<FeatureListViewModel> {
  final String uri;

  FeatureBottomNavigationBar({required this.uri}) : super(uri);

  @override
  Widget errorBuild(BuildContext context, FeatureListViewModel viewmodel) {
    // TODO: implement errorBuild
    throw UnimplementedError();
  }

  @override
  Widget successBuild(BuildContext context, FeatureListViewModel viewmodel) {
    final controller = DefaultTabController.of(context)!;
    final theme = Theme.of(context);
    final router = Scope.valueOf<FeatureRouter>(context);
    final items = viewmodel.subFeatures
        .map(
          (uri) => BottomNavigationBarItem(
            label: uri,
            icon: FeatureTab(
              uri: uri,
              hideTitle: true,
            ),
          ),
        )
        .toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1,
        ),
        Expanded(
          child: WillPopScope(
            onWillPop: () {
              final canPop = router?.pop(
                    viewmodel.subFeatures[controller.index],
                  ) ??
                  false;
              return Future.value(!canPop);
            },
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: theme.colorScheme.secondary,
              elevation: 20,
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                if (index == controller.index) {
                  // If already on the tab and its tapped again, pop to root
                  router?.popToRoot(viewmodel.subFeatures[index]);
                }
                controller.index = index;
              },
              currentIndex: controller.index,
              items: items,
            ),
          ),
        ),
      ],
    );
  }
}
