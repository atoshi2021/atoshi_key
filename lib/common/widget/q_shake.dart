import 'package:atoshi_key/common/widget/shake_animation_widget/shake_animation_controller.dart';
import 'package:atoshi_key/common/widget/shake_animation_widget/shake_animation_type.dart';
import 'package:atoshi_key/common/widget/shake_animation_widget/shake_animation_widget.dart';
import 'package:flutter/material.dart';

class QShake extends StatelessWidget {
  final Widget child;
  final ShakeAnimationController controller;
  final ShakeAnimationType? shakeAnimationType;
  final int? shakeCount;
  final double? shakeRange;

  const QShake(
      {Key? key,
      required this.child,
      required this.controller,
      this.shakeAnimationType,
      this.shakeCount,
      this.shakeRange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShakeAnimationWidget(
        isForward: false,
        shakeAnimationController: controller,
        shakeAnimationType: shakeAnimationType ?? ShakeAnimationType.leftRightShake,
        shakeCount: shakeCount ?? 1,
        shakeRange: shakeRange ?? 0.1,
        child: child);
  }
}
