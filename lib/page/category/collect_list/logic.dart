import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:atoshi_key/common/z_common.dart';

class CollectListLogic extends GetxController {
  late RefreshController smartController;
  RxList<ProjectDetails> list = <ProjectDetails>[].obs;

  @override
  void onInit() {
    smartController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    loading();
    super.onReady();
  }

  void loading() {
    BaseRequest.postResponse(
        Api.queryCategorySubsetList,
        RequestParams.queryCategorySubsetList(
            type: ElementType.requestCategoryListTypeCollect),
        onSuccess: (entity) {
      var list = CategorySubsetListModel.fromJson(entity).data;
      this.list.clear();
      if (list != null && list.isNotEmpty) {
        this.list.addAll(list);
        this.list.logI();
      }
      smartController.refreshCompleted(resetFooterState: true);
    });
  }

  Future<ProjectDetails?> queryProjectDetails(int? categoryId) async {
    if (categoryId == null) {
      return null;
    }
    var publicKey = await QEncrypt.getPublicKey();
    publicKey.logE();
    var response = await BaseRequest.postDefault(
        Api.queryCategoryDetails,
        RequestParams.queryCategoryDetails(
            itemId: categoryId, publicKey: publicKey));
    var result = CategoryProjectDetailsModel.fromJson(response);

    if (result.code == 100) {
      return result.data;
    } else {
      result.message.toString().toast();
      return null;
    }
  }

  void collectCategoryItem(ProjectDetails item, int index) {
    var favorite = ((item.favorite ?? 0) == 0) ? 1 : 0;
    BaseRequest.postResponse(
        Api.categoryCollect,
        RequestParams.categoryCollectParams(
            favorite: favorite, itemId: item.itemId ?? 0), onSuccess: (entity) {
      loading();
    });
  }

  void deleteCategoryItem(ProjectDetails item, index) {
    BaseRequest.postResponse(Api.categoryDelete,
        RequestParams.deleteCollectParams(itemId: item.itemId ?? 0),
        onSuccess: (entity) {
      QString.commonDeleteSuccessfully.tr.toast();
      list.removeAt(index);
    });
  }
}
