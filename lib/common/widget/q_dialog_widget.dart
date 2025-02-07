import 'dart:math';

import 'package:atoshi_key/common/model/category_type_list_model.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../page/z_logic.dart';

class ConfirmDialog extends StatelessWidget {
  final FunctionNone? cancel;
  final FunctionNone confirm;
  final String content;
  final String? cancelTitle;
  final String confirmTitle;
  final bool? cancelOutSide;
  final String? title;

  const ConfirmDialog(
      {Key? key,
      this.title,
      this.cancel,
      required this.confirm,
      this.cancelTitle,
      required this.confirmTitle,
      required this.content,
      this.cancelOutSide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullDialogBg(
      child: Container(
        height: QSize.space150,
        margin: EdgeInsets.symmetric(horizontal: QSize.boundaryDialog50),
        padding: EdgeInsets.all(QSize.boundaryPage15),
        decoration: whiteR10(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle(title),
            buildSecondTitle(title: content),
            QSpace(height: QSize.space10),
            Row(
              children: [
                _buildCancelButton(cancelTitle, cancel),
                QSpace(
                    width: cancelTitle == null ? QSize.space0 : QSize.space10),
                Expanded(
                    child: QButtonRadius(
                  textColor: QColor.white,
                  bgColor: QColor.colorBlue,
                  text: confirmTitle,
                  height: QSize.smallButtonHeight,
                  callback: () {
                    Get.back();
                    confirm.call();
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

_buildTitle(String? title) {
  if (title != null && title.isNotEmpty) {
    return buildTitle(title: title);
  } else {
    return SizedBox(
      height: QSize.space0,
    );
  }
}

_buildCancelButton(String? cancelTitle, FunctionNone? cancel) {
  if (cancelTitle == null || cancelTitle.isEmpty) {
    return QSpace(
      width: QSize.space0,
      height: QSize.space0,
    );
  } else {
    return Expanded(
        child: QButtonRadius(
      textColor: QColor.colorDesc,
      bgColor: QColor.btnGrey,
      text: cancelTitle,
      height: QSize.smallButtonHeight,
      callback: () {
        Get.back();
        cancel?.call();
      },
    ));
  }
}

class FullDialogBg extends StatelessWidget {
  final Widget child;
  final bool? barrierDismissible;

  const FullDialogBg({Key? key, required this.child, this.barrierDismissible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (barrierDismissible ?? true) {
          Get.back();
        }
      },
      child: Container(
        color: QColor.halfTransBg,
        alignment: Alignment.center,
        child: Material(
          color: QColor.transparent,
          child: child,
        ),
      ),
    );
  }
}

Future<T?> showFullScreenDialog<T>(BuildContext context, Widget child,
    {bool barrierDismissible = false}) {
  return showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: _buildMaterialDialogTransitions,
      barrierDismissible: barrierDismissible,
      pageBuilder: (context, animation, secondaryAnimation) {
        return child;
      });
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
    child: child,
  );
}

/// 确认取消弹窗 支持单/双按钮
/// [cancel]
/// [confirm]
/// [content]
/// [cancelTitle]
/// [confirmTitle]
void showCommonDialog({
  required BuildContext context,
  required FunctionNone cancel,
  required FunctionNone confirm,
  required String content,
  String? cancelTitle,
  String? title,
  required String confirmTitle,
}) {
  showFullScreenDialog(
      context,
      ConfirmDialog(
        confirm: confirm,
        confirmTitle: confirmTitle,
        content: content,
        cancel: cancel,
        title: title,
        cancelTitle: cancelTitle,
      ));
}

void showSingleInputDialog(
    {required BuildContext context,
    required FunctionNone cancel,
    required FunctionS confirm,
    String? title,
    String? labelText,
    String? cancelTitle,
    required String confirmTitle}) {
  showFullScreenDialog(
      context,
      SingleInputDialog(
        confirm: confirm,
        confirmTitle: confirmTitle,
        title: title,
        labelText: labelText,
        cancel: cancel,
        cancelTitle: cancelTitle,
      ));
}

class SingleInputDialog extends StatelessWidget {
  final FunctionNone? cancel;
  final FunctionS confirm;
  final String? cancelTitle;
  final String confirmTitle;
  final String? labelText;
  final bool? cancelOutSide;
  final String? title;

  const SingleInputDialog(
      {Key? key,
      this.title,
      this.cancel,
      required this.confirm,
      this.cancelTitle,
      this.labelText,
      required this.confirmTitle,
      this.cancelOutSide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return FullDialogBg(
      child: Container(
        height: QSize.space180,
        margin: EdgeInsets.symmetric(horizontal: QSize.boundaryDialog50),
        padding: EdgeInsets.all(QSize.boundaryPage15),
        decoration: whiteR10(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle(title),
            QSpace(height: QSize.space5),
            _buildInput(controller, labelText),
            QSpace(height: QSize.space5),
            Row(
              children: [
                _buildCancelButton(cancelTitle, cancel),
                QSpace(
                    width: cancelTitle == null ? QSize.space0 : QSize.space10),
                Expanded(
                    child: QButtonRadius(
                  textColor: QColor.white,
                  bgColor: QColor.colorBlue,
                  height: QSize.smallButtonHeight,
                  text: confirmTitle,
                  callback: () {
                    String content = controller.text.trim();
                    if (content.isEmpty) {
                      QString.toastContentEmpty.tr.toast();
                      return;
                    }
                    Get.back();
                    confirm.call(content);
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildInput(TextEditingController controller, String? labelText) {
    return QInputTip(
      controller: controller,
      labelText: labelText,
    );
  }
}

void showCategoryTypeChooseDialog(
    {required BuildContext context,
    required FunctionNone cancel,
    required FunctionInt confirm,
    String? title,
    String? labelText,
    String? cancelTitle,
    required List<CategoryTypeInfo> list,
    required String confirmTitle}) {
  showFullScreenDialog(
      context,
      GridSelectedDialog(
        confirm: confirm,
        confirmTitle: confirmTitle,
        title: title,
        labelText: labelText,
        cancel: cancel,
        cancelTitle: cancelTitle,
        list: list,
      ));
}

class GridSelectedDialog extends StatefulWidget {
  final List<CategoryTypeInfo> list;
  final FunctionNone? cancel;
  final FunctionInt confirm;
  final String? cancelTitle;
  final String confirmTitle;
  final String? labelText;
  final String? title;

  const GridSelectedDialog({
    Key? key,
    required this.list,
    this.title,
    this.cancel,
    required this.confirm,
    this.cancelTitle,
    this.labelText,
    required this.confirmTitle,
  }) : super(key: key);

  @override
  State<GridSelectedDialog> createState() => _GridSelectedDialogState();
}

class _GridSelectedDialogState extends State<GridSelectedDialog> {
  @override
  Widget build(BuildContext context) {
    return FullDialogBg(
      child: Container(
        padding: EdgeInsets.all(QSize.boundaryPage15),
        margin: EdgeInsets.symmetric(horizontal: QSize.boundaryDialog50),
        decoration: whiteR10(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(widget.title),
            QSpace(height: QSize.space15),
            SingleChildScrollView(
              child: Wrap(
                spacing: QSize.space10,
                runSpacing: QSize.space5,
                children: widget.list.map((e) => _buildItem(e)).toList(),
              ),
            ),
            QSpace(height: QSize.space15),
            Row(
              children: [
                _buildCancelButton(widget.cancelTitle, widget.cancel),
                QSpace(
                    width: widget.cancelTitle == null
                        ? QSize.space0
                        : QSize.space10),
                Expanded(
                    child: QButtonRadius(
                  bgColor: QColor.colorBlue,
                  textColor: QColor.white,
                  text: widget.confirmTitle,
                  height: QSize.smallButtonHeight,
                  callback: () {
                    Get.back();
                    CategoryTypeInfo? choose = _findChooseItem(widget.list);
                    widget.confirm.call(choose?.categoryId ?? -1);
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(CategoryTypeInfo e) {
    return InkWell(
      onTap: () => _changeSelected(e),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: QSize.space10, vertical: QSize.space5),
        decoration: e.isChoose ?? false ? blueR10() : greyR10(),
        child: e.isChoose ?? false
            ? buildDescWhiteTitle(title: e.categoryName ?? '')
            : buildDescTitle(title: e.categoryName ?? ''),
      ),
    );
  }

  _changeSelected(CategoryTypeInfo e) {
    for (var element in widget.list) {
      element.isChoose = false;
    }
    e.isChoose = true;
    setState(() {});
  }

  CategoryTypeInfo? _findChooseItem(List<CategoryTypeInfo> list) {
    var listN = list.firstWhere((element) => element.isChoose ?? false);
    if (list.isEmpty) {
      return null;
    }
    return listN;
  }
}

void showAttributeTypeChooseDialog(
    {required BuildContext context,
    required FunctionNone cancel,
    required FunctionInt confirm,
    String? title,
    String? labelText,
    String? cancelTitle,
    required List<AttributeTypeInfo> list,
    required String confirmTitle}) {
  showFullScreenDialog(
      context,
      GridSelectedAttributeTypeDialog(
        confirm: confirm,
        confirmTitle: confirmTitle,
        title: title,
        labelText: labelText,
        cancel: cancel,
        cancelTitle: cancelTitle,
        list: list,
      ));
}

class GridSelectedAttributeTypeDialog extends StatefulWidget {
  final List<AttributeTypeInfo> list;
  final FunctionNone? cancel;
  final FunctionInt confirm;
  final String? cancelTitle;
  final String confirmTitle;
  final String? labelText;
  final String? title;

  const GridSelectedAttributeTypeDialog({
    Key? key,
    required this.list,
    this.title,
    this.cancel,
    required this.confirm,
    this.cancelTitle,
    this.labelText,
    required this.confirmTitle,
  }) : super(key: key);

  @override
  State<GridSelectedAttributeTypeDialog> createState() =>
      _GridSelectedAttributeTypeDialogState();
}

class _GridSelectedAttributeTypeDialogState
    extends State<GridSelectedAttributeTypeDialog> {
  @override
  Widget build(BuildContext context) {
    return FullDialogBg(
      child: Container(
        height: QSize.space180,
        margin: EdgeInsets.symmetric(horizontal: QSize.boundaryDialog50),
        padding: EdgeInsets.all(QSize.boundaryPage15),
        decoration: whiteR10(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle(widget.title),
            QSpace(height: QSize.space5),
            Wrap(
              spacing: QSize.space10,
              runSpacing: QSize.space5,
              children: widget.list.map((e) => _buildItem(e)).toList(),
            ),
            QSpace(height: QSize.space5),
            Row(
              children: [
                _buildCancelButton(widget.cancelTitle, widget.cancel),
                QSpace(
                    width: widget.cancelTitle == null
                        ? QSize.space0
                        : QSize.space10),
                Expanded(
                    child: QButtonRadius(
                  bgColor: QColor.colorBlue,
                  textColor: QColor.white,
                  text: widget.confirmTitle,
                  height: QSize.smallButtonHeight,
                  callback: () {
                    Get.back();
                    AttributeTypeInfo? choose = _findChooseItem(widget.list);
                    widget.confirm.call(choose?.attributeType ?? -1);
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(AttributeTypeInfo e) {
    return InkWell(
      onTap: () => _changeSelected(e),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: QSize.space10, vertical: QSize.space5),
        decoration: e.isChoose ?? false ? blueR10() : greyR10(),
        child: e.isChoose ?? false
            ? buildDescWhiteTitle(title: e.typeName ?? '')
            : buildDescTitle(title: e.typeName ?? ''),
      ),
    );
  }

  _changeSelected(AttributeTypeInfo e) {
    for (var element in widget.list) {
      element.isChoose = false;
    }
    e.isChoose = true;
    setState(() {});
  }

  AttributeTypeInfo? _findChooseItem(List<AttributeTypeInfo> list) {
    var listN = list.firstWhere((element) => element.isChoose ?? false);
    if (list.isEmpty) {
      return null;
    }
    return listN;
  }
}

/// 显示生成随机密码弹窗
void showRandomPasswordDialog(TemplateInfo info, GetxController controller) {
  var globalKey = GlobalKey<NavigatorState>();
  int maxLengthPassword = 32; //Pwd 最长
  int maxLengthPIN = 13; // PIN 最长
  int minLengthPassword = 8; // Pwd 最短
  int minLengthPIN = 3; // PIN 最短
  int defaultLengthPassword = 12; // Pwd 默认 长度
  int defaultLengthPIN = 4; // PIN 默认长度

  String defaultPassword = '\$Tion@5acef8f';
  String defaultPIN = '612';

  RxInt maxLength = 32.obs;
  RxInt minLength = 8.obs;
  RxInt passwordLength = 12.obs;
  RxBool hasCaps = true.obs;
  RxBool hasLower = true.obs;
  RxBool hasNum = true.obs;
  RxBool hasSymbol = true.obs;
  RxString password = defaultPassword.obs;
  // 生成密码还是PIN码 :true 密码，false pin码
  RxBool isCreatePassword = true.obs;
  // RxInt level = 1.obs;
  Get.dialog(
    navigatorKey: globalKey,
    Obx(() {
      return Center(
        child: Container(
          constraints: BoxConstraints(maxHeight: QSize.space400),
          padding: EdgeInsets.all(QSize.boundaryPage15),
          width: QSize.screenW - (2 * QSize.space40),
          decoration: whiteR10(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: greyR2(),
                  height: QSize.smallButtonHeight,
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
                  child: Text(
                    password.value,
                    style: QStyle.secondTitleStyle,
                  ),
                ),
                QSpace(height: QSize.space8),
                SizedBox(
                    height: QSize.space8,
                    child: buildLevel(
                        getLevel(
                            hasCaps: hasCaps.value,
                            hasLower: hasLower.value,
                            hasNum: hasNum.value,
                            hasSymbol: hasSymbol.value),
                        isPassword: isCreatePassword.value,
                        passwordLength: passwordLength.value)),
                QSpace(height: QSize.space8),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        if (isCreatePassword.value) {
                          return;
                        }
                        isCreatePassword.value = !isCreatePassword.value;
                        if (isCreatePassword.value) {
                          hasNum.value = true;
                          hasSymbol.value = true;
                          hasCaps.value = true;
                          hasLower.value = true;
                          maxLength.value = maxLengthPassword;
                          minLength.value = minLengthPassword;
                          passwordLength.value = defaultLengthPassword;
                          password.value = defaultPassword;
                        } else {
                          hasNum.value = true;
                          hasSymbol.value = false;
                          hasCaps.value = false;
                          hasLower.value = false;
                          maxLength.value = maxLengthPIN;
                          minLength.value = minLengthPIN;
                          passwordLength.value = defaultLengthPIN;
                          password.value = defaultPIN;
                        }
                        password.value = _createPassword(
                            passwordLength: passwordLength.value,
                            hasCaps: hasCaps.value,
                            hasLower: hasLower.value,
                            hasNum: hasNum.value,
                            hasSymbol: hasSymbol.value);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: QSize.space5),
                        decoration: BoxDecoration(
                            color: isCreatePassword.value
                                ? QColor.colorBlue
                                : QColor.white,
                            borderRadius: BorderRadius.circular(QSize.space2),
                            border: Border.all(
                                color: isCreatePassword.value
                                    ? QColor.transparent
                                    : QColor.btnGrey)),
                        child: Center(
                          child: isCreatePassword.value
                              ? buildDescWhiteTitle(
                                  title: QString.commonRandomPassword.tr)
                              : buildDescTitle(
                                  title: QString.commonRandomPassword.tr),
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        if (!isCreatePassword.value) {
                          return;
                        }
                        isCreatePassword.value = !isCreatePassword.value;
                        if (isCreatePassword.value) {
                          hasNum.value = true;
                          hasSymbol.value = true;
                          hasCaps.value = true;
                          hasLower.value = true;
                          maxLength.value = maxLengthPassword;
                          minLength.value = minLengthPassword;
                          passwordLength.value = defaultLengthPassword;
                          password.value = defaultPassword;
                        } else {
                          hasNum.value = true;
                          hasSymbol.value = false;
                          hasCaps.value = false;
                          hasLower.value = false;
                          maxLength.value = maxLengthPIN;
                          minLength.value = minLengthPIN;
                          passwordLength.value = defaultLengthPIN;
                          password.value = defaultPIN;
                        }
                        password.value = _createPassword(
                            passwordLength: passwordLength.value,
                            hasCaps: hasCaps.value,
                            hasLower: hasLower.value,
                            hasNum: hasNum.value,
                            hasSymbol: hasSymbol.value);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: QSize.space5),
                        decoration: BoxDecoration(
                            color: !isCreatePassword.value
                                ? QColor.colorBlue
                                : QColor.white,
                            borderRadius: BorderRadius.circular(QSize.space2),
                            border: Border.all(
                                color: !isCreatePassword.value
                                    ? QColor.transparent
                                    : QColor.btnGrey)),
                        child: Center(
                          child: !isCreatePassword.value
                              ? buildDescWhiteTitle(
                                  title: QString.commonPINCode.tr)
                              : buildDescTitle(title: QString.commonPINCode.tr),
                        ),
                      ),
                    ))
                  ],
                ),
                QSpace(height: QSize.space8),
                Row(
                  children: [
                    buildSecondTitle(
                        title:
                            '${QString.categoryPasswordLength.tr} ${passwordLength.value}'),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: QColor.colorDesc, width: QSize.space1),
                        borderRadius: BorderRadius.circular(QSize.r3),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (passwordLength.value > minLength.value) {
                                passwordLength.value -= 1;
                              }
                            },
                            child: const Icon(Icons.remove, size: 20),
                          ),
                          QSpace(width: QSize.space5),
                          buildDescTitle(
                              title: passwordLength.value.toString()),
                          QSpace(width: QSize.space5),
                          InkWell(
                              onTap: () {
                                if (passwordLength.value < maxLength.value) {
                                  passwordLength.value += 1;
                                }
                              },
                              child: const Icon(Icons.add, size: 20)),
                        ],
                      ),
                    )
                  ],
                ),
                QSpace(height: QSize.space2),
                Visibility(
                  visible: isCreatePassword.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSecondTitle(
                          title: '${QString.categoryPasswordCapital.tr} A-Z'),
                      Switch(
                          value: hasCaps.value,
                          onChanged: (_) {
                            hasCaps.value = !hasCaps.value;
                          }),
                    ],
                  ),
                ),
                Visibility(
                    visible: isCreatePassword.value,
                    child: QSpace(height: QSize.space2)),
                Visibility(
                  visible: isCreatePassword.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSecondTitle(
                          title: '${QString.categoryPasswordLower.tr} a-z'),
                      Switch(
                          value: hasLower.value,
                          onChanged: (_) {
                            hasLower.value = !hasLower.value;
                          }),
                    ],
                  ),
                ),
                Visibility(
                    visible: isCreatePassword.value,
                    child: QSpace(height: QSize.space2)),
                Visibility(
                  visible: isCreatePassword.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSecondTitle(
                          title: '${QString.categoryPasswordNumber.tr} 0-9'),
                      Switch(
                          value: hasNum.value,
                          onChanged: (_) {
                            hasNum.value = !hasNum.value;
                          }),
                    ],
                  ),
                ),
                Visibility(
                    visible: isCreatePassword.value,
                    child: QSpace(height: QSize.space2)),
                Visibility(
                  visible: isCreatePassword.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSecondTitle(
                          title:
                              '${QString.categoryPasswordSymbol.tr} ! @#¥%...&* （）？'),
                      Switch(
                          value: hasSymbol.value,
                          onChanged: (_) {
                            hasSymbol.value = !hasSymbol.value;
                          }),
                    ],
                  ),
                ),
                QSpace(height: QSize.space10),
                Row(
                  children: [
                    Expanded(
                        child: QButtonRadius(
                            text: QString.categoryCreate.tr,
                            textColor: QColor.white,
                            bgColor: QColor.colorBlue,
                            height: QSize.smallButtonHeight,
                            callback: () {
                              if (hasCaps.value ||
                                  hasLower.value ||
                                  hasNum.value ||
                                  hasSymbol.value) {
                                password.value = _createPassword(
                                    passwordLength: passwordLength.value,
                                    hasCaps: hasCaps.value,
                                    hasLower: hasLower.value,
                                    hasNum: hasNum.value,
                                    hasSymbol: hasSymbol.value);
                              } else {
                                QString.categoryPasswordHaveNoChoose.tr.toast();
                              }
                            })),
                    QSpace(width: QSize.space20),
                    Expanded(
                        child: QButtonRadius(
                      text: QString.commonConfirm.tr,
                      textColor: QColor.white,
                      bgColor: QColor.colorBlue,
                      height: QSize.smallButtonHeight,
                      callback: () {
                        info.inputController?.text = password.value;
                        Get.back(result: true);
                        controller.update([info.tag ?? '']);
                      },
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }),
    useSafeArea: true,
  );
}

String _createPassword(
    {required int passwordLength,
    bool? hasCaps,
    bool? hasLower,
    bool? hasNum,
    bool? hasSymbol}) {
  var listNum = <String>[];
  _addData(listNum, passwordLength, hasCaps, hasLower, hasNum, hasSymbol);

  StringBuffer sb = StringBuffer();
  var random = Random();
  for (int i1 = 0; i1 < passwordLength; i1++) {
    var r = random.nextInt(listNum.length);
    sb.write(listNum[r]);
    listNum.removeAt(r);
  }
  return sb.toString();
}

void _addData(List<String> listNum, int passwordLength, bool? hasCaps,
    bool? hasLower, bool? hasNum, bool? hasSymbol) {
  if (hasCaps ?? false) {
    listNum.addAll(
        'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z'.split(' '));
  }
  if (hasLower ?? false) {
    listNum.addAll('A B C D E F G H I J K L M N O P Q R S T U V W X Y Z'
        .toLowerCase()
        .split(' '));
  }
  if (hasNum ?? false) {
    listNum.addAll('0 1 2 3 4 5 6 7 8 9'.split(' '));
  }
  if (hasSymbol ?? false) {
    listNum.addAll('! @ # \$ % ^ & * ( )'.split(' '));
  }
  if (listNum.length <= passwordLength) {
    _addData(listNum, passwordLength, hasCaps, hasLower, hasNum, hasSymbol);
  }
}

/// 添加自定义字段' 填写名称'
/// [etController]，输入控制器，只使用一次后重新定义声明
Future<void> showInputTitleDialog(TextEditingController edController) async {
  return Get.dialog(
      Center(
        child: Container(
          constraints: BoxConstraints(maxHeight: QSize.space400),
          padding: EdgeInsets.all(QSize.boundaryPage15),
          width: QSize.screenW - (2 * QSize.space40),
          decoration: whiteR10(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QSpace(height: QSize.space10),
              buildTitle(title: QString.categoryCustomField.tr),
              QSpace(height: QSize.space10),
              QInputTip(
                showClean: true,
                controller: edController,
                labelText: QString.categoryFieldName.tr,
              ),
              QSpace(height: QSize.boundaryPage15),
              Row(
                children: [
                  Expanded(
                      child: QButtonRadius(
                    textColor: QColor.colorDesc,
                    bgColor: QColor.btnGrey,
                    text: QString.commonCancel.tr,
                    height: QSize.smallButtonHeight,
                    callback: () {
                      Get.back(result: null);
                      return;
                    },
                  )),
                  QSpace(width: QSize.space10),
                  Expanded(
                      child: QButtonRadius(
                    textColor: QColor.white,
                    bgColor: QColor.colorBlue,
                    text: QString.commonConfirm.tr,
                    height: QSize.smallButtonHeight,
                    callback: () {
                      var inputValue = edController.text.trim();
                      if (inputValue.isNotEmpty) {
                        Get.back(result: null);
                        return;
                      } else {
                        QString.toastCompleteField.tr.toast();
                      }
                    },
                  ))
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}

/// 通用支付弹窗
Future showPayKeyboard(
    {required RxString password,
    String? paymentAccount,
    Future<dynamic>? submit}) {
  var items = <String>[].obs;
  var error = ''.obs;
  return Get.bottomSheet(Obx(() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: QSize.space5),
      decoration: BoxDecoration(
          color: QColor.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(QSize.space10),
              topRight: Radius.circular(QSize.space10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPayDialogTitle(paymentAccount),
          _buildErrorTip(error.value),
          QSpace(height: QSize.space10),
          _buildPasswordInputWidgets(items),
          QSpace(height: QSize.space10),
          buildSecondTitle(title: _numToInt(paymentAccount ?? '0')+QString.atos.tr),
          QSpace(height: QSize.space10),
          Divider(height: QSize.space1),
          _buildKeyboardWidget(items, error, password, submit: submit)
        ],
      ),
    );
  }));
}

//处理小数点
_numToInt(String Num) {
  double doubleIssString = double.parse(Num);
  String piAsString = doubleIssString.toStringAsFixed(1);
  return piAsString;
}

_buildKeyboardWidget(List<String> values, RxString error, RxString password,
    {Future<dynamic>? submit}) {
  return Container(
    color: QColor.bg,
    child: GridView.builder(
        shrinkWrap: true,
        itemCount: Constant.inputKeyboardData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: QSize.space1,
            crossAxisSpacing: QSize.space1,
            childAspectRatio: 2.6),
        itemBuilder: (context, index) => _buildKeyboardKey(
            context, index, values, error, password,
            submit: submit)),
  );
}

_buildKeyboardKey(BuildContext context, int index, List<String> values,
    RxString error, RxString password,
    {Future<dynamic>? submit}) {
  var key = Constant.inputKeyboardData[index];
  return InkWell(
    onTap: () => _inputKey(key, values, error, password, submit: submit),
    child: Container(
      color: key >= 0 ? QColor.white : QColor.transparent,
      child: Center(
        child: _buildKey(key),
      ),
    ),
  );
}

_inputKey(int key, List<String> values, RxString error, RxString password,
    {Future<dynamic>? submit}) async {
  if (key == -2) {
    if (values.isNotEmpty) {
      values.removeLast();
    }
  } else if (key != -1) {
    if (values.length < 6) {
      values.add(key.toString());
      // values.logE();
      if (values.length == 6) {
        var sb = StringBuffer();
        for (var element in values) {
          sb.write(element);
        }
        password.value = sb.toString();
        var logic = Get.find<VIPPayLogic>();
        var response = await logic.passwordPay(password: password.value);
        // 请求支付接口
        if (response['code'] == 100) {
          Get.back(result: true);
        } else {
          error.value = response['msg'] ?? '';
        }
      }
    }
  }
}

_buildKey(int key) {
  if (key == -1) {
    return const Text('');
  } else if (key == -2) {
    return const Icon(Icons.backspace_rounded);
  } else {
    return buildTitle(title: key.toString());
  }
}

_buildPasswordInputWidgets(List<String> values) {
  return Wrap(
    spacing: QSize.space5,
    children: [1, 2, 3, 4, 5, 6]
        .map((e) => _buildPasswordInputItem(e, values))
        .toList(),
  );
}

Widget _buildPasswordInputItem(int e, List<String> values) {
  return Container(
    width: QSize.space40,
    height: QSize.space40,
    decoration: greyR2(),
    child: Center(
      child: Container(
        width: QSize.space8,
        height: QSize.space8,
        decoration: BoxDecoration(
            color: e <= values.length ? QColor.black : QColor.transparent,
            borderRadius: BorderRadius.circular(QSize.space8)),
      ),
    ),
  );
}

_buildErrorTip(String error) {
  return Visibility(
    visible: error.isNotEmpty,
    child: Container(
      child: buildDescTitle(
          title: error,
          style: TextStyle(fontSize: QSize.font10, color: QColor.colorRed)),
    ),
  );
}

_buildPayDialogTitle(var paymentAccount) {
  return Row(
    children: [
      const Expanded(child: Center()),
      buildSecondTitle(title: QString.enterPaymentPassword.tr),
      Expanded(
          child: Row(
        children: [
          const Spacer(),
          IconButton(
              onPressed: () => Get.back(result: false),
              icon: Icon(
                Icons.close_outlined,
                size: QSize.space20,
              ))
        ],
      )),
    ],
  );
}
