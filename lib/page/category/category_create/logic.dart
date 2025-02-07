import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:atoshi_key/common/z_common.dart';

class CategoryCreateLogic extends GetxController {
  List<AttributeTypeInfo> attributeTypeList = [];
  TextEditingController? autoAttributeTitleController;
  String? avatar;
  String? filePath;
  CategorySubsetParams? typeInfo;

  /// 系统属性
  List<TemplateInfo> mTemplateList = [];

  late TextEditingController itemNameController;

  /// 输入框控制器
  List<TextEditingController> inputController = [];

  String idListView = 'id_list_view';

  String idAvatar = 'id_avatar';

  String idAutoAttribute = 'id_auto_attribute';

  String idLabel = 'id_label';
  List<LabelInfo> labels = [];

  ASEPublicKey? _publicKey;
  String? key;

  late Random random;

  late String addLabelStr;

  @override
  void onInit() {
    super.onInit();
    random = Random();
    addLabelStr = '+ ${QString.categoryNewLabel.tr}';
    labels.add(LabelInfo(labelId: -1, labelName: addLabelStr));
    itemNameController = TextEditingController();
    typeInfo = Get.arguments as CategorySubsetParams;
    avatar = typeInfo?.icon;
  }

  @override
  void onReady() async {
    getCategoryTemplateInfo();
    super.onReady();
  }

  void updateAvatar({String? tag}) {
    update([tag ?? idAvatar]);
  }

  void getCategoryTemplateInfo() async {
    int categoryId = typeInfo?.categoryId ?? 0;
    BaseRequest.postResponse(Api.categoryTemplateInfo,
        RequestParams.getCategoryTemplateInfoParams(categoryId: categoryId),
        onSuccess: (entity) async {
      if (entity != null && entity.toString().isNotEmpty) {
        if (entity == null || entity.toString().isEmpty) {
          // '数据错误'.toast();
          Get.back();
        } else {
          var data = CategoryAttributeModel.fromJson(entity);
          var list = data.data;
          if (list == null || list.isEmpty) {
            // '数据错误'.toast();
            Get.back();
          } else {
            mTemplateList.addAll(list);
            _processingTemplates();
            update([idListView]);
          }
        }
      }
    });
  }

  save() async {
    if (!_checkAttribute()) {
      return;
    }
    if (_hasPassword() && (key == null || key!.isEmpty)) {
      await _getPasswordKey();
    }
    if (filePath != null && filePath!.isNotEmpty) {
      BaseRequest.uploadFile(File(filePath ?? ''), -1, onSuccess: ((entity) {
        avatar = entity.toString();
        uploadImageFile();
      }));
    } else {
      uploadImageFile();
    }
  }

  bool _hasPassword() {
    for (var element in mTemplateList) {
      if (element.attributeType == AttributeType.attributeTypePassword1) {
        return true;
      }
    }
    return false;
  }

  /// 上传文件参数
  void uploadImageFile() async {
    for (var element in mTemplateList) {
      if (element.attributeType == AttributeType.attributeTypeImage0 &&
          !element.value.toString().startsWith('http')) {
        var response =
            await BaseRequest.uploadFileDefault(File(element.value ?? ''));
        if (response['code'].toString() == '100') {
          element.value = response['data'];
        } else {
          response['msg'].toString().toast();
          break;
        }
      }
    }
    _uploadInfo();
  }

  void _uploadInfo() async {
    var itemName = itemNameController.text.trim();

    if (itemName.isEmpty) {
      QString.toastPleaseEnterProjectName.tr.toast();
      return;
    }
    var favorite = 0;
    avatar ??= Constant.userDefaultHeader;

    var params = {
      'itemName': itemName,
      'favorite': favorite,
      'avatar': avatar,
      'categoryId': typeInfo?.categoryId ?? ''
    };
    var labelIds = '';
    StringBuffer sb = StringBuffer();
    labels.removeLast();
    for (var element in labels) {
      sb.write(element.labelId ?? '');
      sb.write(',');
    }
    if (sb.isNotEmpty) {
      labelIds = sb.toString().substring(0, sb.length - 1);
    }
    if (labelIds.isNotEmpty) {
      params['labelIds'] = labelIds;
    }
    if (_publicKey != null) {
      params['itemId'] = _publicKey?.data?.itemId ?? 0;
    }
    var attributes = jsonEncode(await _getRequestAttributes());
    params['attribute'] = attributes;
    BaseRequest.postResponse(Api.createSubject, params, onSuccess: (entity) {
      /// 创建项目成功
      // '创建成功'.toast();
      Get.back();
    });
  }

  /// 参数校验
  bool _checkAttribute() {
    for (var i = 0; i < mTemplateList.length; i++) {
      if (mTemplateList[i].inputController != null) {
        mTemplateList[i].value = mTemplateList[i].inputController!.text.trim();
      }

      var value = mTemplateList[i].value;
      // var value = (mTemplateList[i].inputController == null)
      // ? mTemplateList[i].value
      // : mTemplateList[i].inputController!.text.trim();
      if ((value == null || value.isEmpty) &&
          // ((mTemplateList[i].base ?? 1) == 1 ||
          (mTemplateList[i].required ?? 1) == 1) {
        // '${QString.toastPleaseEnterX.tr}${mTemplateList[i].attributeHint}的内容'
            QString.toastCompleteField.tr.toast();
        return false;
      }
    }
    return true;
  }

  Future<List<Map<String, dynamic>>> _getRequestAttributes() async {
    var list = <Map<String, dynamic>>[];
    var length = mTemplateList.length;
    for (var i = 0; i < length; i++) {
      var value = mTemplateList[i].value;
      var map = {
        'keyboardType': mTemplateList[i].keyboardType,
        'attributeType': mTemplateList[i].attributeType,
        'attributeHint': mTemplateList[i].attributeHint,
        'keyboardLength': mTemplateList[i].keyboardLength,
        'value': (value != null && value.isNotEmpty)
            ? ((mTemplateList[i].attributeType ==
                    AttributeType.attributeTypePassword1)
                ? QEncrypt.encryptAES_(value, key ?? '')
                : value)
            : '',
        'required': mTemplateList[i].required,
        'base': mTemplateList[i].base,
      };
      list.add(map);
    }
    return list;
  }

  Future<List<AttributeTypeInfo>> queryAttributeTypeList() async {
    if (attributeTypeList.isNotEmpty) {
      return attributeTypeList;
    }
    var response = await BaseRequest.getDefault(Api.queryAttributeTypeList);
    var data = AttributeTypeModel.fromJson(response);
    if (data.code == 100) {
      var list = data.data;
      if (list != null && list.isNotEmpty) {
        attributeTypeList.addAll(list);
      }
    }
    return attributeTypeList;
  }

  /// 手动增加自定义属性
  void addAttribute(int index, {String? title}) {
    var attribute = attributeTypeList[index];
    var attributeType = attribute.attributeType ?? 0;
    var info = TemplateInfo(
        keyboardType: 0,
        attributeType: attributeType,
        attributeHint: title ?? attribute.typeName,
        keyboardLength: 100,
        value: null,
        base: 0,
        required: 1,
        tag: DateTime.now().millisecondsSinceEpoch.toString(),
        inputController:
            (attributeType == AttributeType.attributeTypePassword1 ||
                    attributeType == AttributeType.attributeTypeText2)
                ? TextEditingController()
                : null,
        focusNode: (attributeType == AttributeType.attributeTypePassword1 ||
                attributeType == AttributeType.attributeTypeText2)
            ? FocusNode()
            : null,
        isNew: true);

    mTemplateList.add(info);
    update([idListView]);
  }

  /// 处理数据
  /// 文本、密码类型数据需要绑定TextEditingController
  /// 给每个非必需变量增加一个tag「时间戳」，删除时使用
  void _processingTemplates() {
    for (var element in mTemplateList) {
      if (element.attributeType == AttributeType.attributeTypeText2 ||
          element.attributeType == AttributeType.attributeTypePassword1) {
        element.inputController ??= TextEditingController(text: element.value);
        // element.attributeHint.logE();
      }
      if ((element.base ?? 1) == 0) {
        element.tag ??= DateTime.now().millisecondsSinceEpoch.toString();
      }
    }
  }

  void removeAttribute(int index) {
    if (index <= mTemplateList.length - 1) {
      mTemplateList.removeAt(index);
      update([idListView]);
    } else {
      // '数据错误'.toast();
    }
  }

  void changeTime(int index, DateTime time) {
    mTemplateList[index].value = '${time.year} - ${time.month} - ${time.day}';
    update([idListView]);
  }

  _getPasswordKey() async {
    String publicKey = await QEncrypt.getPublicKey();
    var response = await BaseRequest.postDefault(
        Api.getAESKey,
        RequestParams.getAESKeyParams(
            publicKey: publicKey.replaceAll(' ', '')));
    _publicKey = ASEPublicKey.fromJson(response);
    if (_publicKey?.code != 100) {
      _publicKey?.message ?? ''.toast();
      return;
    }
    var cipherText = _publicKey?.data?.ciphertext;
    if (cipherText == null || cipherText.isEmpty) {
      return;
    }
    // 'ciphertext:$cipherText'.logE();
    key = await QEncrypt.decrypt(cipherText);
    // 'key:$key'.logE();
    if (key == null || key!.isEmpty) {
      return;
    }
  }

  String getAvatar() {
    // avatar.logE();
    if (avatar == null || avatar!.isEmpty) {
      return filePath.toString();
    } else {
      return avatar!;
    }
  }

  changeLabel(List<LabelInfo>? label) {
    label.toString().logD();
    if (label == null) {
      return;
    }

    labels.clear();
    if (label.isNotEmpty) {
      labels.addAll(label);
      labels.add(LabelInfo(labelId: -1, labelName: addLabelStr));
      update([idLabel]);
    }
  }
}
