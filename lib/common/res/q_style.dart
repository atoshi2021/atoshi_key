import 'package:flutter/material.dart';
import 'z_res.dart';

class QStyle {
  static TextStyle bigStyle = TextStyle(
    color: QColor.colorTitle,
    fontSize: QSize.font26,
    fontWeight: FontWeight.normal,
  );
  static TextStyle titleStyle = TextStyle(
    color: QColor.colorTitle,
    fontSize: QSize.title18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle secondTitleStyle = TextStyle(
      color: QColor.colorSecondTitle,
      fontSize: QSize.secondTitle15,
      fontWeight: FontWeight.w300);
  static TextStyle secondTitleWhiteStyle = TextStyle(
      color: QColor.white,
      fontSize: QSize.secondTitle15,
      fontWeight: FontWeight.w300);

  static TextStyle secondTitleGreyStyle = TextStyle(
      color: QColor.colorDesc,
      fontSize: QSize.secondTitle15,
      fontWeight: FontWeight.w300);
  static TextStyle secondTitleBlueStyle = TextStyle(
      color: QColor.colorBlue,
      fontSize: QSize.secondTitle15,
      fontWeight: FontWeight.w300);
  static TextStyle descStyle = TextStyle(
    color: QColor.colorDesc,
    fontSize: QSize.desc11,
  );
  static TextStyle descStyleWhite = TextStyle(
    color: QColor.white,
    fontSize: QSize.desc12,
  );

  /// 蓝色
  static TextStyle blueStyle = TextStyle(
    color: QColor.colorBlue,
    fontSize: QSize.buttonTitle16,
    fontWeight: FontWeight.bold,
  );

  /// 蓝色
  static TextStyle blueStyle14 = TextStyle(
    color: QColor.colorBlue,
    fontSize: QSize.buttonTitle14,
  );

  /// 白色
  static TextStyle whiteStyle = TextStyle(
    color: QColor.white,
    fontSize: QSize.buttonTitle16,
    fontWeight: FontWeight.bold,
  );

  static List<BoxShadow> blueShadow = [
    BoxShadow(
      color: QColor.colorBlueEndTrans25,
      blurRadius: QSize.space5,
      offset: Offset(1.0, QSize.space5),
    )
  ];
}
