import 'dart:convert';

import 'package:atoshi_key/common/get/base_category_controller.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

class HomeLogic extends BaseCategoryController {
  var categoryTypes = <CategoryTypeInfo>[];
  var homeList = <HomeFolder>[];

  var idList = 'id_list';

  @override
  void onReady() {
    super.onReady();
    getHomeFoldersAndItems();
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

  Future<void> getHomeFoldersAndItems() async {
    var response = await BaseRequest.getDefault(Api.itemThemeAndItemList);
    var result = HomeFolderSortListModel.fromJson(response);
    if (result.code == 100) {
      // var sortList = <HomeFolder>[];
      // if (homeList.isNotEmpty) {
      //   sortList.addAll(homeList);
      // }

      homeList.clear();
      homeList
          .add(HomeFolder(name: QString.passwordRecycleBin.tr, isShow: false));
      var list = result.data;
      if (list != null && list.isNotEmpty) {
        homeList.addAll(list);
        homeList.sort(
            (left, right) => (left.sort ?? -1).compareTo(right.sort ?? -1));

        // if (sortList.isNotEmpty) {
        //   for (var i = 0; i < sortList.length; i++) {
        //     var sortItem = sortList[i];
        //     for (var j = 0; j < homeList.length; j++) {
        //       if (sortItem.id == homeList[j].id) {
        //         homeList[j].isShow = sortItem.isShow;
        //         break;
        //       }
        //     }
        //   }
        // }
      }

      update([idList]);
    } else {
      result.message.toast();
    }

    if (categoryTypes.isEmpty || Constant.isChangeLanguage) {
      Constant.isChangeLanguage = false;
      getAllCategoryType();
    }
  }

  // 修改 列表的折叠打开
  changeThemeListState(int index) {
    var state = homeList[index].isShow ?? false;
    homeList[index].isShow = !state;
    confirmThemeSort(index: index);
    update(['$idList-$index']);
  }

  Future<void> confirmThemeSort({required int index}) async {
    var list = [];
    // for (var i = 0; i < userItemThemes.length; i++) {
    //   var item = userItemThemes[i];
    //   list.add({'id': item.id, 'sort': i + 1, 'exhibition': item.exhibition});
    // }
    // var list = [];
    var item = homeList[index];
    list.add({
      'id': item.id,
      'sort': item.sort,
      'exhibition': item.exhibition,
      'isShow': item.isShow
    });
    var itemThemeList = jsonEncode(list);
    var result = await BaseRequest.postDefault(Api.updateItemTheme,
        RequestParams.updateItemTheme(itemThemeList: itemThemeList));
    BaseResponse response = BaseResponse.fromJson(result);
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
