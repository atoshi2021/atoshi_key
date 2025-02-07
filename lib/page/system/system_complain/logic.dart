import 'dart:io';

import 'package:atoshi_key/common/z_common.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SystemComplainLogic extends GetxController {
  final String idComplainType = 'id_complain_type';
  final complainType = [
    QString.systemDysfunction.tr,
    QString.systemSuggestedUse.tr,
    QString.systemFunctionalRequirement.tr,
    QString.commonOther.tr,
  ];
  String? complainTypeChoose;
  late TextEditingController complainController;

  /// 文件路径-地址
  final List<String> files = [];
  final int maxFileCount = 3;

  var idPhotos = 'id_photos';

  //当吊起拍照时候关闭 锁定
  var isOpenExitLock = (ServiceUser.to.userinfo.exitLock ?? 0) == 1;
  final unreadQuantity = 0.obs;

  @override
  void onInit() {
    complainTypeChoose = complainType[0];
    complainController = TextEditingController();
    super.onInit();
    Constant.isChangeLock = false;
  }

  @override
  void onReady() {
    getReplyCount();
    super.onReady();
  }

  @override
  void onClose() {
    changeExitLock(isOpenExitLock);
  }

  /// 设置是否退出时锁定
  changeExitLock(bool onChanged) {
    isOpenExitLock ? Constant.isChangeLock = true : false;
  }

  void changeSelectedType(String value) {
    complainTypeChoose = value;
    update([idComplainType]);
  }

  void addPhoto(File file) {
    files.add(file.path);
    update([idPhotos]);
  }

  void removePhoto(int index) {
    files.removeAt(index);
    update([idPhotos]);
  }

  void submitComplain() async {
    var description = complainController.text;
    if (description.length < 10) {
      QString.tipComplaintContention.tr.toast();
      return;
    }
    var type = 0;
    for (var i = 0; i < complainType.length; i++) {
      if (complainType[i] == complainTypeChoose) {
        type = i;
        break;
      }
    }
    _uploadFile(description: description, type: type);
  }

  void _uploadFile({required String description, required int type}) async {
    for (var i = 0; i < files.length; i++) {
      var element = files[i];
      if (!element.startsWith('http://') && !element.startsWith('https://')) {
        var response = await BaseRequest.uploadFileDefault(File(element));
        if (response['code'].toString() == '100') {
          var imageUrl = response['data'];
          files[i] = imageUrl;
        } else {
          response['msg'].toString().toast();
          return;
        }
      }
    }
    _submitCompletion(description: description, type: type);
  }

  void _submitCompletion({required String description, required int type}) {
    StringBuffer sb = StringBuffer();
    if (files.isNotEmpty) {
      for (var element in files) {
        sb.write(element);
        sb.write(',');
      }
    }
    BaseRequest.postResponse(
        Api.commitComplain,
        RequestParams.commitComplain(
            type: type,
            description: description,
            images: sb.toString()), onSuccess: (entity) {
      QString.toastFeedback.tr.toast();
      complainController.clear();
    });
  }

  void getReplyCount() {
    BaseRequest.getResponse(Api.replyCount, onSuccess: ((entity) {
      unreadQuantity.value = entity['data'];
    }));
  }

  launchURL(String url) async {
    // const url = 'https://leshua.info/';
    await launch(url, forceSafariVC: false);
  }

  Future<bool> checkAppInstalled() async {
    bool isAppInstalled = false;
    try {
      isAppInstalled = await DeviceApps.isAppInstalled('com.huawei.appmarket');
    } catch (e) {
      print('检查应用安装状态时出错: $e');
    }
    return isAppInstalled;
  }
}
