import 'package:atoshi_key/common/get/base_category_controller.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/page/z_logic.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategorySubsetListLogic extends BaseCategoryController {
  late int categoryId;
  late String categoryName;
  String? icon;

  late RefreshController smartRefreshController;

  RxList<ProjectDetails> list = <ProjectDetails>[].obs;

  var categoryTypes = <CategoryTypeInfo>[];

  @override
  void onInit() {
    super.onInit();
    smartRefreshController = RefreshController();
    var entity = Get.arguments as CategorySubsetParams;
    categoryId = entity.categoryId;
    categoryName = entity.categoryName;
    icon = entity.icon;
  }

  @override
  void onReady() {
    loading();
    if (categoryId == -1) {
      getAllCategoryType();
    }
    super.onReady();
  }

  void loading() {
    BaseRequest.postResponse(
        Api.queryCategorySubsetList,
        RequestParams.queryCategorySubsetList(
            categoryId: categoryId,
            type: categoryId == -1
                ? ElementType.requestCategoryListTypeAll
                : ElementType.requestCategoryListTypeSingle),
        onSuccess: (entity) {
      var list = CategorySubsetListModel.fromJson(entity).data;
      this.list.clear();
      if (list != null && list.isNotEmpty) {
        this.list.addAll(list);
        // this.list.logI();
      }
      smartRefreshController.refreshCompleted(resetFooterState: false);
    }, onFailed: ((code, msg) {
      smartRefreshController.refreshCompleted(resetFooterState: false);
    }));
  }

  void collectCategoryItem(ProjectDetails item, int index) {
    var favorite = ((item.favorite ?? 0) == 0) ? 1 : 0;
    BaseRequest.postResponse(
        Api.categoryCollect,
        RequestParams.categoryCollectParams(
            favorite: favorite, itemId: item.itemId ?? 0), onSuccess: (entity) {
      // Get.find<CollectListLogic>().loading();
      loading();
    });
  }

  void deleteCategoryItem(ProjectDetails item, index) {
    BaseRequest.postResponse(Api.categoryDelete,
        RequestParams.deleteCollectParams(itemId: item.itemId ?? 0),
        onSuccess: (entity) {
      QString.commonDeleteSuccessfully.tr.toast();
      // Get.find<CollectListLogic>().loading();
      list.removeAt(index);
    });
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

  void getAllCategoryType() {
    BaseRequest.getResponse(Api.queryCategoryTypeList, onSuccess: ((entity) {
      categoryTypes.clear();
      if (entity != null && entity.toString().isNotEmpty) {
        var typeList = CategoryTypeListModel.getCategoryTypeList(entity);
        categoryTypes.addAll(typeList);
      }
    }));
  }
}
