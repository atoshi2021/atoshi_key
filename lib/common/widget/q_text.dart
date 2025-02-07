import 'package:atoshi_key/common/res/z_res.dart';
import 'package:flutter/material.dart';

Widget buildTitle({required String title, TextStyle? style}) {
  return Text(title, style: style ?? QStyle.titleStyle);
}

Widget buildSecondTitle({required String title, TextStyle? style}) {
  return Text(title, style: style ?? QStyle.secondTitleStyle);
}

Widget buildDescTitle({required String title, TextStyle? style}) {
  return Text(title, style: style ?? QStyle.descStyle);
}

Widget buildDescWhiteTitle({required String title, TextStyle? style}) {
  return Text(title, style: style ?? QStyle.descStyleWhite);
}
