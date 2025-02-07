import 'package:get/get.dart';

import '../../common/z_common.dart';

class LabelLogic extends GetxController {
  var userLabels = <LabelInfo>[].obs;

  @override
  void onReady() {
    queryUserLabels();
    super.onReady();
  }

  void queryUserLabels() {
    BaseRequest.getResponse(Api.queryUserLabel, onSuccess: ((entity) {
      userLabels.clear();
      var response = UserLabelModel.fromJson(entity).data;
      if (response != null && response.isNotEmpty) {
        userLabels.addAll(response.reversed);
      }
    }));
  }
}
