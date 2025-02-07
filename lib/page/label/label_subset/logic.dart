import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LabelSubsetLogic extends GetxController {
  late int labelId;
  late String labelName;

  late RefreshController smartRefreshController;

  RxList<ProjectDetails> list = <ProjectDetails>[].obs;

  @override
  void onInit() {
    var params = Get.parameters;
    labelId = int.parse(params['labelId'] ?? '0');
    labelName = params['labelName'] ?? '';

    smartRefreshController = RefreshController();
    'labelId:$labelId'.logW();
    super.onInit();
  }

  @override
  void onReady() {
    _getLabelSubset();
    super.onReady();
  }

  @override
  void onClose() {
    smartRefreshController.dispose();
    super.onClose();
  }

  void _getLabelSubset() {
    BaseRequest.postResponse(Api.queryLabelProjects,
        RequestParams.queryLabelProjects(labelId: labelId),
        onSuccess: (entity) {
      var list = CategorySubsetListModel.fromJson(entity).data;
      this.list.clear();
      if (list != null && list.isNotEmpty) {
        this.list.addAll(list);
        this.list.logI();
      }
      smartRefreshController.refreshCompleted(resetFooterState: false);
    }, onFailed: ((code, msg) {
      smartRefreshController.refreshCompleted(resetFooterState: false);
    }));
  }

  void loading() {
    _getLabelSubset();
  }

  Future<ProjectDetails?> queryProjectDetails(int? categoryId) async {
    if (categoryId == null) {
      return null;
    }
    var response = await BaseRequest.postDefault(
        Api.queryCategoryDetails,
        RequestParams.queryCategoryDetails(
            itemId: categoryId, publicKey: await QEncrypt.getPublicKey()));
    var result = CategoryProjectDetailsModel.fromJson(response);

    if (result.code == 100) {
      return result.data;
    } else {
      result.message.toString().toast();
      return null;
    }
  }
}
