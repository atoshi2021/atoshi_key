import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class QScaffold extends StatelessWidget {
  bool? isShowAppBar;
  String? title;
  bool? isCenterTitle;
  Widget body;
  Color? appBarColor;
  Color? backgroundColor;
  Color? titleColor;
  bool? isDefaultPadding;
  double? elevation;
  FunctionNone? function;
  List<Widget>? actions;
  SystemUiOverlayStyle? systemOverlayStyle;
  BottomNavigationBar? bottomNavigationBar;
  bool? resizeToAvoidBottomInset;
  Widget? floatingActionButton;
  FunctionNone? backFunction;

  /// 用来清除页面焦点

  QScaffold(
      {Key? key,
      required this.body,
      this.isShowAppBar,
      this.appBarColor,
      this.backgroundColor,
      this.title,
      this.titleColor,
      this.isCenterTitle,
      this.isDefaultPadding,
      this.elevation,
      this.function,
      this.actions,
      this.systemOverlayStyle,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.resizeToAvoidBottomInset,
      this.backFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        resetAutoLockTime();
      },
      onTap: () {
        /// 隐藏软键盘
        function?.call();
        SystemChannels.textInput.invokeListMethod('TextInput.hide');
      },
      child: Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
          backgroundColor: backgroundColor,
          appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton),
    );
  }

  _buildAppBar() {
    // if (isShowAppBar ?? false) {
    if (isShowAppBar ?? false || (title != null && title!.isNotEmpty)) {
      return AppBar(
        systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
        backgroundColor: appBarColor ?? QColor.colorBlue,
        elevation: elevation,
        title: Text(
          title ?? '',
          style: TextStyle(color: titleColor),
        ),
        centerTitle: isCenterTitle ?? true,
        actions: actions,
        leading: GestureDetector(
          onTap: () {
            if (backFunction == null) {
              Get.back();
            }
            backFunction?.call();
          },
          child: const Icon(Icons.arrow_back),
        ),
      );
    }
  }

  _buildBody() {
    if (isDefaultPadding ?? false) {
      return SafeArea(child: QPadding(child: body));
    } else {
      return SafeArea(child: body);
    }
  }
}
