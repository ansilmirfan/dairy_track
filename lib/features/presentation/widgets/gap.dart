import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final bool width;
  final double gap;
  const Gap({super.key, this.gap = 10, this.width = false});
  factory Gap.width({double gap = 10}) {
    return Gap(width: true, gap: gap);
  }

  @override
  Widget build(BuildContext context) {
    if (width) {
      return SizedBox(width: gap);
    } else {
      return SizedBox(height: gap);
    }
  }
}
