import 'package:flutter/material.dart';

class QSpace extends StatelessWidget {
  final double? height;
  final double? width;
  const QSpace({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }
}
