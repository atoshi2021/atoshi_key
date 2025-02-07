import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget loadEmpty({String? text}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Assets.imagesIcEmpty,
          width: QSize.space150,
          fit: BoxFit.contain,
        ),
        buildDescTitle(title: text ?? QString.commonContentEmpty.tr)
      ],
    ),
  );
}
