import 'dart:io';

import 'package:atoshi_key/common/res/z_res.dart';
import 'package:atoshi_key/common/widget/z_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';

Future<dynamic> showPhotoChooseDialog(
    BuildContext context, bool? isCompress, bool? isCrop, int? quality) async {
  final ImagePicker picker = ImagePicker();

  return showModalBottomSheet(
      context: context,
      backgroundColor: QColor.transparent,
      isScrollControlled: false,
      builder: ((context) {
        return Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(
              left: QSize.boundaryPage15,
              right: QSize.boundaryPage15,
              bottom: QSize.space30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: whiteR10(),
                child: Column(
                  children: [
                    QButtonRadius(
                      radius: QSize.space10,
                      bgColor: QColor.transparent,
                      textColor: QColor.colorSecondTitle,
                      text: QString.commonAlbum.tr,
                      callback: () async {
                        XFile? file = await picker.pickImage(
                          source: ImageSource.gallery,
                          maxWidth: 1080,
                          maxHeight: 2500,
                          imageQuality:
                              (isCompress ?? false) ? (quality ?? 100) : 100,
                        );
                        File? fileNew =
                            await compressAndCrop(isCompress, isCrop, file);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop(fileNew);
                      },
                    ),
                    QSpace(height: QSize.space1),
                    QButtonRadius(
                      radius: QSize.space10,
                      bgColor: QColor.transparent,
                      textColor: QColor.colorSecondTitle,
                      text: QString.commonCamera.tr,
                      callback: () async {
                        XFile? file = await picker.pickImage(
                          source: ImageSource.camera,
                          maxWidth: 1080,
                          maxHeight: 2500,
                          imageQuality:
                              (isCompress ?? false) ? (quality ?? 100) : 100,
                        );
                        File? fileNew =
                            await compressAndCrop(isCompress, isCrop, file);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop(fileNew);
                      },
                    ),
                  ],
                ),
              ),
              QSpace(height: QSize.space1),
              QButtonRadius(
                text: QString.commonCancel.tr,
                callback: () => Get.back(),
              )
            ],
          ),
        );
      }));
}

Future<File?> compressAndCrop(
    bool? isCompress, bool? isCrop, XFile? file) async {
  if (file == null) {
    return null;
  }
  if (isCompress ?? false) {
    File? fileNew = await compressImage(file);
    if (isCrop ?? false) {
      File? cropFile = await cropImage(fileNew, isCompress);
      return cropFile;
    } else {
      return fileNew;
    }
  } else {
    return File(file.path);
  }
}

Future<File?> cropImage(File? value, bool? isCompress) async {
  if (value != null && (isCompress ?? false)) {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: value.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    return File(croppedFile!.path);
  } else {
    return null;
  }
}

Future<File?> compressImage(XFile? value) async {
  if (value == null) {
    return null;
  }
  if (EasyLoading.isShow) {
    EasyLoading.show();
  }
  try {
    Directory tempDir = await getTemporaryDirectory();
    String imgCachedPath = tempDir.path;
    var result = await FlutterImageCompress.compressAndGetFile(value.path,
        '$imgCachedPath/${DateTime.now().millisecondsSinceEpoch}.jpg',
        quality: 20);
    return result;
  } catch (e) {
    // ignore: avoid_print
    print('e');
  } finally {
    EasyLoading.dismiss();
  }
  return null;
}
