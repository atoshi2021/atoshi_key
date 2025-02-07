import 'dart:convert';
import 'dart:io';

import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryUpdateLogic extends GetxController {
  late TextEditingController itemNameController;

  /// 输入框控制器
  List<TextEditingController> inputController = [];

  ProjectDetails? details;

  /// 自定义字段控制器
  TextEditingController? autoAttributeTitleController;

  /// 系统属性
  List<TemplateInfo> mTemplateList = [];
  List<AttributeTypeInfo> attributeTypeList = [];

  String? filePath;
  String? avatar;

  String idListView = 'id_list_view';
  var idAvatar = 'id_avatar';

  String idLabel = 'id_label';
  List<LabelInfo> labels = [];
  late String addLabelStr;

  ASEPublicKey? _publicKey;
  String? key;

  @override
  void onInit() async {
    details = Get.arguments as ProjectDetails;
    addLabelStr = '+ ${QString.categoryNewLabel.tr}';
    avatar = details?.avatar;
    var labelList = details?.labels;
    if (labelList != null && labelList.isNotEmpty) {
      labels.addAll(labelList);
    }
    labels.add(LabelInfo(labelId: -1, labelName: addLabelStr));

    itemNameController = TextEditingController(text: details?.itemName);
    super.onInit();
  }

  @override
  onReady() async {
    getProjectDetails();
  }

  updateProject() async {

    if (!_checkAttribute()) {
      QString.toastCompleteField.tr.toast();
      return;
    }
    if (_hasPassword() && details != null && (key == null || key!.isEmpty)) {
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

  void _uploadInfo() {
    var itemId = details?.itemId ?? 0;
    var itemName = itemNameController.text.trim();

    if (itemName.isEmpty) {
      // '${QString.toastPleaseEnterX.tr}${QString.categoryProjectName.tr}的内容'
          QString.toastCompleteField.tr.toast();
      // '请输入项目名称'.toast();
      return;
    }
    var favorite = details?.favorite ?? 0;
    avatar ??= Constant.userDefaultHeader;

    var params = {
      'itemId': itemId,
      'itemName': itemName,
      'favorite': favorite,
      'avatar': avatar,
      'categoryId': details?.categoryId ?? ''
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

    var attributes = jsonEncode(_getRequestAttributes());
    params['attribute'] = attributes;
    BaseRequest.postResponse(Api.updateProject, params, onSuccess: (entity) {
      /// 创建项目成功
      QString.commonUpdateSuccessfully.tr.toast();
      Get
        ..back()
        ..back();
    });
  }

  save() {

    var itemId = details?.itemId ?? 0;
    var itemName = itemNameController.text.trim();

    if (itemName.isEmpty) {
      QString.toastPleaseEnterProjectName.tr.toast();
      return;
    }
    var favorite = details?.favorite ?? 0;
    avatar ??= Constant.userDefaultHeader;

    var params = {
      'itemId': itemId,
      'itemName': itemName,
      'favorite': favorite,
      'avatar': avatar,
      'categoryId': details?.categoryId ?? ''
    };

    var attributes = jsonEncode(_getRequestAttributes());
    params['attribute'] = attributes;
    BaseRequest.postResponse(Api.updateProject, params, onSuccess: (entity) {

      /// 创建项目成功
      QString.commonUpdateSuccessfully.tr.toast();
      // Get.find<CollectListLogic>().loading();
      Get
        ..back()
        ..back();
    });
  }

  /// 参数校验
  bool _checkAttribute() {
    for (var i = 0; i < mTemplateList.length; i++) {
      if (mTemplateList[i].inputController != null) {
        mTemplateList[i].value = mTemplateList[i].inputController!.text.trim();
      }
      var value = mTemplateList[i].value;
      if ((value == null || value.isEmpty) &&
          // ((mTemplateList[i].base ?? 1) == 1 ||
          ((mTemplateList[i].required ?? 1) == 1)) {
        return false;
      }
    }
    return true;
  }

  List<Map<String, dynamic>> _getRequestAttributes() {
    var list = <Map<String, dynamic>>[];
    var length = mTemplateList.length;
    for (var i = 0; i < length; i++) {
      var map = {
        'keyboardType': mTemplateList[i].keyboardType,
        'attributeType': mTemplateList[i].attributeType,
        'attributeHint': mTemplateList[i].attributeHint,
        'keyboardLength': mTemplateList[i].keyboardLength,
        'value':
            (mTemplateList[i].value == null || mTemplateList[i].value!.isEmpty)
                ? ''
                : (mTemplateList[i].attributeType ==
                        AttributeType.attributeTypePassword1)
                    ? QEncrypt.encryptAES_(mTemplateList[i].value, key ?? '')
                    : mTemplateList[i].value,
        'required': mTemplateList[i].required,
        'base': mTemplateList[i].base,
      };
      list.add(map);
    }
    return list;
  }

  void _processingTemplates() {
    var list = details?.attribute;
    if (list != null && list.isNotEmpty) {
      mTemplateList.addAll(list);
    }
    for (var element in mTemplateList) {
      if (element.attributeType == AttributeType.attributeTypeText2 ||
          element.attributeType == AttributeType.attributeTypePassword1) {
        if (element.attributeType == AttributeType.attributeTypePassword1) {
          var inputContent = element.value;
          if (inputContent != null && inputContent.isNotEmpty) {
            var result = QEncrypt.decryptAES_(inputContent, key ?? '');
            element.value = result;
          }
        }
        element.inputController ??= TextEditingController(text: element.value);
      }
      if ((element.base ?? 1) == 0) {
        element.tag ??= DateTime.now().millisecondsSinceEpoch.toString();
      }
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

  void updateAvatar({String? tag}) {
    update([tag ?? idAvatar]);
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

  bool _hasPassword() {
    for (var element in mTemplateList) {
      if (element.attributeType == AttributeType.attributeTypePassword1) {
        return true;
      }
    }
    return false;
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
    key = await QEncrypt.decrypt(cipherText);
    if (key == null || key!.isEmpty) {
      ///解密错误
      return;
    }
  }

  void getProjectDetails() async {
    var itemId = details?.itemId ?? 0;
    var publicKey = await QEncrypt.getPublicKey();
    var response = await BaseRequest.postDefault(
        Api.queryCategoryDetails,
        RequestParams.queryCategoryDetails(
            itemId: itemId, publicKey: publicKey));
    var result = CategoryProjectDetailsModel.fromJson(response);

    if (result.code == 100) {
      details = result.data;
      itemNameController.text = details?.itemName ?? '';
      var ciphertext = result.data?.ciphertext;
      // 'ciphertext:$ciphertext'.logE();
      if (ciphertext != null && ciphertext.isNotEmpty) {
        key = await QEncrypt.decrypt(ciphertext);
      }
      _processingTemplates();
      update([idListView]);
    } else {
      result.message?.toast();
      Get.back();
      return;
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
