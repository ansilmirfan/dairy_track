import 'package:dairy_track/features/presentation/themes/themes.dart';

import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final double padding;
  const ElevatedContainer(
      {super.key, required this.child, this.padding = 10.0});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: Themes.radius10,
      color: Themes.secondary,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
