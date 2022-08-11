import 'package:feature_based_app/common/object_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopupContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const PopupContainer({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(8.0);
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.7,
      maxChildSize: 1.0,
      builder: (context, controller) {
        return Scope(
          value: controller,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
                borderRadius:
                    BorderRadius.only(topLeft: radius, topRight: radius),
                child: Container(
                  color: backgroundColor,
                  child: Stack(
                    children: [
                      child,
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                            ),
                            child: SizedBox(
                              width: 40,
                              height: 4,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
