import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class QInputTip extends StatefulWidget {
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? labelText;
  final InputBorder? inputBorder;
  final TextEditingController controller;
  final String? errorText;
  final FocusNode? focusNode;
  final bool? showClean;
  final bool? showCopy;
  bool isShowDelete = false;
  final bool? showSetting;
  final bool? isPassword;
  final Function? settings;

  final bool? enabled;

  QInputTip(
      {Key? key,
      required this.controller,
      this.maxLines,
      this.minLines,
      this.maxLength,
      this.keyboardType,
      this.labelText,
      this.inputBorder,
      this.errorText,
      this.focusNode,
      this.showClean,
      this.showCopy,
      this.isPassword,
      this.showSetting,
      this.settings,
      this.enabled})
      : super(key: key);

  @override
  State<QInputTip> createState() => _QInputTipState();
}

class _QInputTipState extends State<QInputTip> {
  bool hidePassword = false;

  @override
  void initState() {
    hidePassword = widget.isPassword ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled ?? true,
      obscureText: hidePassword,
      controller: widget.controller,
      maxLines: widget.maxLines,
      minLines: widget.minLines ?? 1,
      maxLength: widget.maxLength ?? 30,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      onChanged: (value) {
        setState(() {
          widget.isShowDelete = value.isNotEmpty;
        });
      },
      decoration: InputDecoration(
        counterText: '',
        errorText: widget.errorText,
        border: widget.inputBorder ??
            UnderlineInputBorder(
                borderSide:
                    BorderSide(width: QSize.space1 / 2, color: QColor.bg)),
        labelText: widget.labelText,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ((widget.showSetting ?? false))
                ? IconButton(
                    onPressed: () {
                      widget.settings?.call();
                    },
                    // style: ButtonStyle(
                    //   padding: MaterialStateProperty.all(EdgeInsets.zero),
                    //   minimumSize: MaterialStateProperty.all(Size.zero),
                    // ),
                    icon: Icon(Icons.settings_outlined, size: QSize.space15))
                : const Text(''),
            (widget.isPassword ?? false)
                ? eyeImage(hidePassword, () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  })
                : const Text(''),
            ((widget.showClean ?? false) && widget.controller.text.isNotEmpty)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.controller.text = '';
                      });
                    },
                    icon: Icon(
                      Icons.highlight_remove,
                      size: QSize.space15,
                    ))
                : const Text(''),
            ((widget.showCopy ?? false) && widget.controller.text.isNotEmpty)
                ? IconButton(
                    onPressed: () {
                      var text = widget.controller.text.trim();
                      if (text.isNotEmpty) {
                        text.copy();
                      }
                    },
                    icon: Icon(
                      Icons.copy,
                      size: QSize.space15,
                    ))
                : const Text('')
          ],
        ),
      ),
    );
  }
}

class QInputPassword extends StatefulWidget {
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? labelText;
  final InputBorder? inputBorder;
  final TextEditingController controller;
  final String? errorText;
  final FocusNode? focusNode;
  final bool? suffixIcon;

  const QInputPassword(
      {Key? key,
      required this.controller,
      this.maxLines,
      this.maxLength,
      this.keyboardType,
      this.labelText,
      this.inputBorder,
      this.errorText,
      this.focusNode,
      this.suffixIcon})
      : super(key: key);

  @override
  State<QInputPassword> createState() => _QInputPasswordState();
}

class _QInputPasswordState extends State<QInputPassword> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hidePassword,
      controller: widget.controller,
      maxLines: widget.maxLines ?? 1,
      focusNode: widget.focusNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxLength ?? 100),
        // FilteringTextInputFormatter(RegExp("^[a-z0-9A-Z]+"), allow: true)
      ],
      keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
      decoration: InputDecoration(
        counterText: '',
        suffixIcon: _buildSufWidget(),
        errorText: widget.errorText,
        border: widget.inputBorder ??
            UnderlineInputBorder(
                borderSide:
                    BorderSide(width: QSize.space1 / 2, color: QColor.bg)),
        labelText: widget.labelText,
      ),
    );
  }

  Widget? _buildSufWidget() {
    if (!(widget.suffixIcon ?? true)) {
      return null;
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          hidePassword = !hidePassword;
        });
      },
      child: _buildEyes(),
    );
  }

  _buildEyes() {
    if (hidePassword) {
      return ImageIcon(
        const AssetImage(Assets.imagesIcEyeClose),
        color: QColor.colorSecondTitle,
      );
    } else {
      return ImageIcon(const AssetImage(Assets.imagesIcEyeOpen),
          color: QColor.colorSecondTitle);
    }
  }
}
