import 'package:atoshi_key/common/model/feedback_details_model.dart';
import 'package:atoshi_key/common/model/z_model.dart';
import 'package:atoshi_key/common/net/z_net.dart';
import 'package:get/get.dart';

class SystemFeedbackDetailsLogic extends GetxController {
  late int parentId;
  List<FeedbackDetailsInfo> detailsList = <FeedbackDetailsInfo>[].obs;

  @override
  void onInit() {
    parentId = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    getFeedbackDetails();
    super.onReady();
  }

  void getFeedbackDetails() {
    BaseRequest.postResponse(
        Api.feedbackDetails, RequestParams.feedbackDetails(parentId: parentId),
        onSuccess: (entity) {
      var list = FeedbackDetailsModel.fromJson(entity).data;
      detailsList.addAll(list as Iterable<FeedbackDetailsInfo>);
    }, onFailed: ((code, msg) {}));
  }
}
