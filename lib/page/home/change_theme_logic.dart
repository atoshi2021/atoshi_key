import 'dart:convert';

import 'package:get/get.dart';

import '../../common/z_common.dart';

class ChangeThemeLogic extends GetxController {
  var idConfigList = 'id_config_list';

  var userItemThemes = <HomeFolder>[];

  Future<void> getHomeFolderSort() async {
    var response = await BaseRequest.getDefault(Api.itemThemeList);
    var result = HomeFolderSortListModel.fromJson(response);
    if (result.code == 100) {
      var list = result.data;
      if (list != null && list.isNotEmpty) {
        userItemThemes.clear();
        userItemThemes.addAll(list);
        userItemThemes.sort(
            (left, right) => (left.sort ?? -1).compareTo(right.sort ?? -1));
      }
      print('制定主页======='+response.toString());
    } else {
      result.message.toast();
    }
  }

  void changeIndex(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = userItemThemes.removeAt(oldIndex);
    userItemThemes.insert(newIndex, item);
    update([idConfigList]);
  }

  void changeState(int id) {
    var item = userItemThemes.firstWhere((element) => element.id == id);
    item.exhibition = !(item.exhibition ?? false);
    update([idConfigList]);
  }

  Future<bool> confirmThemeSort() async {
    var list = [];
    for (var i = 0; i < userItemThemes.length; i++) {
      var item = userItemThemes[i];
      list.add({
        'id': item.id,
        'sort': i + 1,
        'exhibition': item.exhibition,
        'isShow': (item.isShow ?? false)
      });
    }
    var itemThemeList = jsonEncode(list);
    var result = await BaseRequest.postDefault(Api.updateItemTheme,
        RequestParams.updateItemTheme(itemThemeList: itemThemeList));
    BaseResponse response = BaseResponse.fromJson(result);
    if (response.code == 100) {
      return true;
    } else {
      response.message.toast();
      return false;
    }
  }
}
