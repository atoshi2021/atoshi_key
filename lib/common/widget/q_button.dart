import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:atoshi_key/common/z_common.dart';

///默认输入框
buildInputDefault(TextEditingController controller, String labelText,
    {bool? showClean,
    bool? showCopy,
    bool? isPassword,
    bool? showSetting,
    Function? settings,
    FocusNode? focusNode,
    Color? backgroundColor,
    int? maxLength,
    int? maxLines,
    InputBorder? inputBorder}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
    color: backgroundColor ?? QColor.white,
    child: QInputTip(
      showClean: showClean,
      showCopy: showCopy,
      controller: controller,
      labelText: labelText,
      isPassword: isPassword,
      showSetting: showSetting,
      settings: settings,
      focusNode: focusNode,
      maxLength: maxLength,
      maxLines: maxLines,
      inputBorder: inputBorder,
    ),
  );
}

/// 自动填充
class QButtonParcel extends StatelessWidget {
  final String text;
  final Color? fillColor;
  final Color? textColor;
  final double? radio;
  final FunctionNone function;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final bool? enable;
  final OutlinedBorder? shape;

  const QButtonParcel(this.text, this.function,
      {Key? key,
      this.fillColor,
      this.textColor,
      this.radio,
      this.paddingVertical,
      this.paddingHorizontal,
      this.enable,
      this.shape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => function.call(),
      style: ElevatedButton.styleFrom(
          enableFeedback: enable ?? true,
          shadowColor: fillColor ?? QColor.bg,
          shape: shape ?? const StadiumBorder(),
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal ?? QSize.space20,
              vertical: paddingVertical ?? QSize.space8)),
      child: Text(
        text,
        style: TextStyle(
            fontSize: QSize.desc12, color: textColor ?? QColor.colorTitle),
      ),
    );
  }
}

/// 最小宽度
class QButtonFill extends StatelessWidget {
  final String text;
  final Color? fillColor;
  final Color? textColor;
  final Color? borderColor;
  final double? radius;
  final double? height;
  final double? minWidth;
  final FunctionNone callback;

  const QButtonFill(
      {Key? key,
      required this.text,
      required this.callback,
      this.fillColor,
      this.textColor,
      this.borderColor,
      this.height,
      this.minWidth,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => callback.call(),
      color: fillColor ?? context.theme.primaryColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor ?? QColor.transparent,
          width: QSize.space1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? QSize.r3)),
      ),
      height: height ?? QSize.space50,
      minWidth: minWidth ?? QSize.space80,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: QSize.font13, color: textColor ?? QColor.white),
        ),
      ),
    );
  }
}

class QButtonText extends StatelessWidget {
  final double? height;
  final String text;
  final FunctionNone? function;
  final bool? enable;
  final TextStyle? style;

  const QButtonText(
      {Key? key,
      this.height,
      required this.text,
      this.function,
      this.enable,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => function?.call(),
        child: SizedBox(
          height: height ?? QSize.space40,
          child: Center(
            child: Text(text, style: style ?? QStyle.secondTitleStyle),
          ),
        ));
  }
}

/// 渐变 gradual
/// 自动填充
class QButtonGradual extends StatelessWidget {
  final String text;
  final Color? fillColor;
  final Color? textColor;
  final double? radio;
  final FunctionNone function;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final bool? enable;
  final OutlinedBorder? shape;
  final List<BoxShadow>? boxShadow;

  const QButtonGradual(
      {Key? key,
      required this.text,
      required this.function,
      this.fillColor,
      this.textColor,
      this.radio,
      this.paddingVertical,
      this.paddingHorizontal,
      this.enable,
      this.shape,
      this.boxShadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function.call(),
      child: Container(
        alignment: Alignment.center,
        height: QSize.buttonHeight,
        //在此设置
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          borderRadius:
              BorderRadius.circular((QSize.buttonHeight ~/ 2).toDouble()),
          gradient: LinearGradient(
              colors: (fillColor != null)
                  ? [fillColor!.withOpacity(0.6), fillColor!]
                  : [QColor.colorBlueStart, QColor.colorBlueEnd]),
        ),
        child: Text(text,
            style: (textColor == null)
                ? QStyle.whiteStyle
                : QStyle.whiteStyle.copyWith(color: textColor)),
        // child: ElevatedButton(
        //   onPressed: () => function.call(),
        //   style: ButtonStyle(
        //     //去除阴影
        //     elevation: MaterialStateProperty.all(0),
        //     //将按钮背景设置为透明
        //     backgroundColor: MaterialStateProperty.all(Colors.transparent),
        //   ),
        //   child: Text(
        //     text,
        //     style: QStyle.whiteStyle,
        //   ),
        // ),
      ),
    );
  }
}

/// border 按钮
/// 自动填充
class QButtonBorder extends StatelessWidget {
  final String text;
  final Color? fillColor;
  final Color? textColor;
  final Color? borderColor;
  final double? radio;
  final FunctionNone function;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final bool? enable;
  final OutlinedBorder? shape;

  const QButtonBorder(
      {Key? key,
      required this.text,
      required this.function,
      this.fillColor,
      this.textColor,
      this.borderColor,
      this.radio,
      this.paddingVertical,
      this.paddingHorizontal,
      this.enable,
      this.shape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function.call(),
      child: Container(
        alignment: Alignment.center,
        height: QSize.buttonHeight,
        //在此设置
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular((QSize.buttonHeight ~/ 2).toDouble()),
          border: Border.all(
              width: QSize.space1 / 2,
              color: borderColor ?? QColor.colorBlueEnd),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: borderColor ?? QColor.colorBlueEnd,
              fontSize: QSize.buttonTitle16),
        ),
        // child: ElevatedButton(
        //   onPressed: () => function.call(),
        //   style: ButtonStyle(
        //     //去除阴影
        //     elevation: MaterialStateProperty.all(0),
        //     //将按钮背景设置为透明
        //     backgroundColor: MaterialStateProperty.all(Colors.transparent),
        //   ),
        //   child: Text(
        //     text,
        //     style: TextStyle(
        //         color: borderColor ?? QColor.colorBlueEnd,
        //         fontSize: QSize.buttonTitle16),
        //   ),
        // ),
      ),
    );
  }
}

class QButtonRadius extends StatelessWidget {
  final double? radius;
  final Color? bgColor;
  final String text;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final FunctionNone? callback;

  const QButtonRadius(
      {Key? key,
      this.radius,
      this.bgColor,
      required this.text,
      this.textColor,
      this.fontSize,
      this.callback,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback?.call(),
      child: Container(
          alignment: Alignment.center,
          height: height ?? QSize.buttonHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? QSize.r3),
              color: bgColor ?? QColor.white),
          child: Text(
            text,
            style: TextStyle(
                color: textColor ?? QColor.colorTitle,
                fontSize: fontSize ?? QSize.buttonTitle14),
          )),
    );
  }
}
