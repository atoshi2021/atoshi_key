import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';

/// 构建 密码安全等级
buildLevel(int level, {bool? isPassword, int? passwordLength}) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              QColor.btnGrey,
              QColor.colorBlueStart,
              QColor.colorYellow,
              QColor.colorRed
            ])),
      ),
      _buildStrengthGrade(
          level: level,
          isPassword: isPassword ?? true,
          passwordLength: passwordLength),
    ],
  );
}

_buildStrengthGrade(
    {required int level, required bool isPassword, int? passwordLength}) {
  if (isPassword) {
    return Row(
      children: [
        Expanded(flex: level, child: Container(color: QColor.transparent)),
        Expanded(flex: (4 - level), child: Container(color: QColor.white))
      ],
    );
  } else {
    return Row(
      children: [
        Expanded(
            flex: passwordLength ?? 3,
            child: Container(color: QColor.transparent)),
        Expanded(
            flex: (18 * 4 - (passwordLength ?? 3)),
            child: Container(color: QColor.white))
      ],
    );
  }
}
