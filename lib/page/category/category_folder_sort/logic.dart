import 'package:get/get.dart';

class CategoryFolderSortLogic extends GetxController {
  var list = <String>[];

  var idList = 'id_list';

  @override
  void onInit() {
    list.add('收藏夹');
    list.add('最近创建');
    list.add('使用频率');
    list.add('最近使用');
    list.add('最近更改');
    list.add('全部项目');
    //自定义：Customize
    // 定制主页：Customize Home
    // 长按拖动进行重新排序：Drag and hold to reorder
    super.onInit();
  }

  void changeIndex(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    update([idList]);
  }
}
