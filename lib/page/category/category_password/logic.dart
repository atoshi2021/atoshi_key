import 'package:atoshi_key/common/model/delete_item_model.dart';
import 'package:get/get.dart';

import '../../../common/z_common.dart';

class CategoryPasswordLogic extends GetxController {
  List<DeleteItemData> deleteItemList = <DeleteItemData>[].obs;
  var idDeleteItemList = 'id_delete_item_list';
  var click = false.obs;

  @override
  void onReady() async {
    getDeleteItemList();
    super.onReady();
  }

  void getDeleteItemList() {
    BaseRequest.postResponse(Api.deletList, {}, onSuccess: (entity) {
      var list = DeleteItemModel.fromJson(entity).data;
      deleteItemList.clear();
      deleteItemList.addAll(list as Iterable<DeleteItemData>);
      update([idDeleteItemList]);
    }, onFailed: ((code, msg) {}));
  }

  void changeStatus(bool value, int index) {
    deleteItemList[index].isSelect = value;
    update([idDeleteItemList]);
    clickable();
  }

  void selectAll() {
    for (var item in deleteItemList) {
      item.isSelect = true;
    }
    clickable();
  }

  void clickable() {
    click.value = false;
    for (var item in deleteItemList) {
      if (item.isSelect!) {
        click.value = true;
      }
    }
    update([idDeleteItemList]);
  }

  void undelete() {
    List itemIdList = [];
    for (var item in deleteItemList) {
      if (item.isSelect!) {
        itemIdList.add(item.itemId);
      }
    }
    BaseRequest.postResponse(
        Api.unDelete, RequestParams.unDelete(itemIdList: itemIdList),
        onSuccess: (entity) {
      getDeleteItemList();
    }, onFailed: ((code, msg) {}));
  }
}
