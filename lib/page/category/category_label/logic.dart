import 'dart:math';

import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

class CategoryLabelLogic extends GetxController {
  List<LabelInfo> labels = [];
  List<LabelInfo> userLabels = [];
  var idAllLabels = 'id_all_label';
  var idProjectLabel = 'id_project_label';

  late Random random;

  String addLabelStr = 'xx ${QString.categoryNewLabel.tr} xx';

  @override
  void onInit() {
    var label = Get.arguments as List<LabelInfo>;
    if (label.isNotEmpty) {
      labels.addAll(label);
      labels.removeLast();
    }

    userLabels.add(LabelInfo(labelId: -1, labelName: addLabelStr));
    random = Random();
    super.onInit();
  }

  @override
  void onReady() {
    loading();
    super.onReady();
  }

  void loading() {
    _queryUserLabels();
  }

  void _queryUserLabels() {
    BaseRequest.getResponse(Api.queryUserLabel, onSuccess: ((entity) {
      userLabels.clear();
      var response = UserLabelModel.fromJson(entity).data;
      if (response != null && response.isNotEmpty) {
        userLabels.addAll(response.reversed);
        userLabels.add(LabelInfo(labelId: -1, labelName: addLabelStr));
        update([idAllLabels]);
      }
    }));
  }

  void addLabel(String labelName) {
    BaseRequest.post(Api.addLabel, RequestParams.addLabel(label: labelName),
        onSuccess: (entiry) {
      loading();
    });
  }

  /// 给项目增加标签
  void bindLabel(LabelInfo label) {
    var isHas = false;
    for (var element in labels) {
      if (element.labelId == label.labelId) {
        isHas = true;
      }
    }
    if (!isHas) {
      labels.add(LabelInfo(labelId: label.labelId, labelName: label.labelName));
      update([idAllLabels, idProjectLabel]);
    } else {
      QString.commonHasBeenAdded.tr.toast();
    }
  }

  /// 取消标签绑定
  void unBindLabel(LabelInfo label) {
    labels.remove(label);
    update([idAllLabels, idProjectLabel]);
  }

  bool isBindChoose(LabelInfo label) {
    bool isBind = false;
    if (labels.isEmpty) {
      return false;
    }

    for (var element in labels) {
      if (element.labelId == label.labelId) {
        isBind = true;
      }
    }
    return isBind;
  }
}
