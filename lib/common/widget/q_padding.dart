import 'package:atoshi_key/common/res/z_res.dart';
import 'package:flutter/material.dart';

class QPadding extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Widget child;
  const QPadding(
      {required this.child,
      Key? key,
      this.top,
      this.bottom,
      this.left,
      this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: left ?? QSize.boundaryPage15,
          top: top ?? 0,
          right: right ?? QSize.boundaryPage15,
          bottom: bottom ?? 0),
      child: child,
    );
  }
}
