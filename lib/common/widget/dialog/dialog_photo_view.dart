import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

Future<void> imagePreView({required List<String> httpUrl, int? index = 0}) {
  RxInt currentIndex = 0.obs;
  if (currentIndex.value >= httpUrl.length) {
    currentIndex.value = 0;
  }
  final pageController = PageController();
  return Get.dialog(Scaffold(
    backgroundColor: QColor.black,
    appBar: AppBar(
      backgroundColor: QColor.transparent,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: QSize.space10, vertical: QSize.space10),
          child: Icon(
            Icons.arrow_back_ios,
            size: QSize.space20,
            color: QColor.white,
          ),
        ),
      ),
      title: Text(
        '${currentIndex.value} / ${httpUrl.length}',
        style: TextStyle(color: QColor.white, fontWeight: FontWeight.bold),
      ),
    ),
    body: Material(
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(httpUrl[index]),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes: PhotoViewHeroAttributes(
                    tag: httpUrl[index]
                        .substring(httpUrl[index].lastIndexOf('/'))),
              );
            },
            itemCount: httpUrl.length,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            (event.expectedTotalBytes ?? 1)),
              ),
            ),
            pageController: pageController,
            onPageChanged: (index) {
              currentIndex.value = index;
            },
          )
        ],
      ),
    ),
  ));
}

/// 单张图片查看
/// 参数 [type] 类型 [net] 网络图片，[assets]、本地图片
Future<void> imagePreViewSingle({required String url, required UrlType type}) {
  return Get.dialog(Scaffold(
    backgroundColor: QColor.black,
    appBar: AppBar(
      backgroundColor: QColor.transparent,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: QSize.space10, vertical: QSize.space10),
          child: Icon(
            Icons.arrow_back_ios,
            size: QSize.space20,
            color: QColor.white,
          ),
        ),
      ),
    ),
    body: PhotoView(imageProvider: getProvider(type, url)),
  )
);}

ImageProvider getProvider(UrlType type, String url) {
  if (type == UrlType.assets) {
    return AssetImage(url);
  } else {
    return NetworkImage(url);
  }
}

enum UrlType { assets, net }
