import 'package:atoshi_key/common/model/feedback_list_model.dart';
import 'package:atoshi_key/common/res/q_color.dart';
import 'package:atoshi_key/common/res/q_string.dart';
import 'package:atoshi_key/common/route/app_routes.dart';
import 'package:atoshi_key/common/utils/q_time.dart';
import 'package:atoshi_key/common/widget/z_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class SystemMyFeedbackPage extends GetView<SystemMyFeedbackLogic> {
  const SystemMyFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return QScaffold(
        backgroundColor: QColor.white,
        title: QString.myFeedback.tr,
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("上拉加载");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("加载失败！点击重试！");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("松手,加载更多!");
                } else {
                  body = const Text("没有更多数据了!");
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: controller.refreshController,
            onRefresh: () {
              controller.onRefresh();
            },
            onLoading: () {
              controller.onLoading();
            },
            child: buildList()),
      );
    });
  }

  ListView buildList() {
    return ListView.separated(
      itemCount: controller.feedbackList.length,
      itemBuilder: (context, index) {
        FeedbackInfo item = controller.feedbackList[index];
        return InkWell(
          onTap: () {
            AppRoutes.toNamed(AppRoutes.systemFeedbackDetails,
                    arguments: item.id)
                .then((value) {
              controller.getFeedbackList();
            });
          },
          child: _buildListItem(item),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.grey,
          thickness: 1,
          endIndent: 15,
          indent: 15,
        );
      },
    );
  }

  Widget _buildListItem(FeedbackInfo item) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 8.h, bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: QColor.colorSecondTitle,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                buildDescTitle(title: timeDisplayFormat(item.createTime!))
              ],
            ),
          ),
          Container(
            width: 65.w,
            height: 20.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 0.8),
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: Text(
              item.status == 1 ? '待处理' : '已处理',
              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
            ),
          ),
          const SizedBox(width: 8),
          buildSecondTitle(
              title: '查看详情',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: QColor.colorSecondTitle)),
          const SizedBox(width: 8),
          item.viewStatus == 1
              ? Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: QColor.colorRed,
                    borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
