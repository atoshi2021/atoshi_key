import 'package:atoshi_key/common/res/z_res.dart';
import 'package:flutter/material.dart';

BoxDecoration whiteR10({double? radius}) => BoxDecoration(
    color: QColor.white,
    boxShadow: [
      BoxShadow(
          color: QColor.btnGrey,
          offset: Offset(QSize.space2, QSize.space2),
          blurRadius: 2,
          spreadRadius: 2)
    ],
    borderRadius: BorderRadius.circular(radius ?? QSize.space10));

BoxDecoration greyR2() => BoxDecoration(
    color: QColor.btnGrey, borderRadius: BorderRadius.circular(QSize.r3));

BoxDecoration greyR10() => BoxDecoration(
    color: QColor.btnGrey, borderRadius: BorderRadius.circular(QSize.space10));

BoxDecoration blueR10() => BoxDecoration(
    color: QColor.colorBlue,
    borderRadius: BorderRadius.circular(QSize.space10));
