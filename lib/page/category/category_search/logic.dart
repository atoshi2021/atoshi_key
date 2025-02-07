import 'package:atoshi_key/common/get/base_category_controller.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategorySearchLogic extends BaseCategoryController {
  late TextEditingController searchController;
  var index = 0;
  var idTab = 'id_tab';
  var idList = 'id_list';
  var value = '';
  var oldSearchText = '';
  List<ProjectDetails> list = <ProjectDetails>[];

  var categoryTypes = <CategoryTypeInfo>[];

  @override
  void onInit() {
    searchController = TextEditingController();
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
    getAllCategoryType();
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

  void search({String? text}) {
    var searchText = searchController.text.trim();
    if (searchText.isEmpty) {
      if (text != null && text.isNotEmpty) {
        searchText = text;
      } else {
        list.clear();
        update([idList]);
        // QString.categoryPleaseEnterSearchContent.tr.toast();
        return;
      }
    }
    oldSearchText = searchText;
    BaseRequest.postResponse(Api.categorySearch,
        RequestParams.categorySearch(field: searchText, searchType: index),
        onSuccess: (entity) {
      var list = CategorySubsetListModel.fromJson(entity).data;
      this.list.clear();
      if (list != null && list.isNotEmpty) {
        this.list.addAll(list);
        this.list.logI();
      }
      update([idList]);
    });
  }

  changeTab(int tabIndex) {
    if (tabIndex != index) {
      index = tabIndex;
      search();
      update([idTab]);
    }
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

  void loading() {
    search(text: oldSearchText);
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

  void deleteCategoryItem(ProjectDetails item, int index) {
    BaseRequest.postResponse(Api.categoryDelete,
        RequestParams.deleteCollectParams(itemId: item.itemId ?? 0),
        onSuccess: (entity) {
      QString.commonDeleteSuccessfully.tr.toast();
      // Get.find<CollectListLogic>().loading();
      list.removeAt(index);
      loading();
    });
  }
}
