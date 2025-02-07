import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:atoshi_key/common/model/category_type_list_model.dart';
import 'package:atoshi_key/generated/assets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:atoshi_key/common/z_common.dart';

class CategoryListLogic extends BaseController {
  var list = <CategoryInfo>[].obs;
  var categoryTypes = <CategoryTypeInfo>[];

  final actionTypes = [
    QString.typeLogin.tr,
    QString.typePayCard.tr,
    QString.typeIdentityInfo.tr,
    QString.typeSafetyInfo.tr
  ];

  late RefreshController smartRefreshController;

  @override
  void onReady() {
    super.onReady();
    smartRefreshController = RefreshController();
    getAllCategory();
  }

  createDocument(String value) {
    // ignore: avoid_print
    // print('创建文件类型：$value');
  }

  void getAllCategory() {
    BaseRequest.get(
      Api.queryCategoryList,
      onSuccess: ((entity) {
        list.clear();
        list.add(CategoryInfo(
            icon: Assets.imagesIcProjectAll,
            count: 0,
            categoryName: QString.categoryAllProjects.tr,
            categoryId: -1));
        if (entity != null && entity.toString().isNotEmpty) {
          var data = CategoryListModel.getList(entity);
          if (data.isNotEmpty) {
            list.addAll(data);
          }
        }
        _resetAllProjectCount();
        getAllCategoryType();
        smartRefreshController.refreshCompleted(resetFooterState: true);
      }),
      onFailed: (code, msg) {
        smartRefreshController.refreshCompleted(resetFooterState: true);
        getAllCategoryType();
      },
    );
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

  void getCategoryTemplateInfo(int categoryId) {
    BaseRequest.postResponse(Api.categoryTemplateInfo,
        RequestParams.getCategoryTemplateInfoParams(categoryId: categoryId),
        onSuccess: (entity) {
      if (entity != null && entity.toString().isNotEmpty) {
        AppRoutes.toNamed(AppRoutes.categoryCreate, arguments: entity);
      }
    });
  }

  void _resetAllProjectCount() {
    var size = list.length;
    var count = 0;
    for (int i = 1; i < size; i++) {
      count += list[i].count??0;
    }
    list[0].count = count;
  }
}
