import 'dart:math';

import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/page/category/collect_list/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailsLogic extends GetxController {
  late bool _isHidePasswordDefault;
  late Random _random;

  late TextEditingController itemNameController;

  ProjectDetails? details;

  String? filePath;
  String? key;
  List<TemplateInfo>? attribute;

  var idListView = 'id_list';

  var idCollect = 'id_collect';

  var idLabels = 'id_labels';
  List<TemplateInfo> newAttributes = [];

  @override
  void onInit() {
    _random = Random();
    details = Get.arguments as ProjectDetails;
    attribute = details?.attribute;
    attribute?.forEach((element) {
      if (element.value != null && element.value!.isNotEmpty) {
        newAttributes.add(element);
      }
    });
    itemNameController = TextEditingController(text: details?.itemName);
    _isHidePasswordDefault = ((ServiceUser.to.userinfo.hidePassword ?? 0) == 1);
    super.onInit();
  }

  @override
  void onReady() async {
    if (details?.ciphertext != null && details!.ciphertext!.isNotEmpty) {
      key = await QEncrypt.decrypt(details!.ciphertext ?? '');
    }
    await _processingTemplates();
    update([idListView]);
    super.onReady();
  }

  void deleteProject() {
    BaseRequest.postResponse(Api.categoryDelete,
        RequestParams.deleteCollectParams(itemId: details?.itemId ?? 0),
        onSuccess: (entity) {
      // Get.find<CollectListLogic>().loading();
      QString.commonDeleteSuccessfully.tr.toast();
      Get.back();
    });
  }

  void collectProject() {
    var favorite = 1 - (details?.favorite ?? 0);
    BaseRequest.postResponse(
        Api.categoryCollect,
        RequestParams.categoryCollectParams(
            favorite: favorite,
            itemId: details?.itemId ?? 0), onSuccess: (entity) {
      details?.favorite = favorite;
      update([idCollect]);
      Get.find<CollectListLogic>().loading();
    });
  }

  Future<void> _processingTemplates() async {
    var list = details?.attribute;
    if (list != null && list.isNotEmpty) {
      for (var element in list) {
        element.tag =
            (_random.nextInt(100000) + _random.nextInt(100000)).toString();
        if (element.attributeType == AttributeType.attributeTypePassword1) {
          element.value =
              await QEncrypt.decryptAES_(element.value ?? '', key ?? '');
          element.isShow = !_isHidePasswordDefault;
        }
      }
    }
  }

  void showOrHide(TemplateInfo info) {
    info.isShow = !info.isShow;
    update([info.tag ?? '']);
  }
}
