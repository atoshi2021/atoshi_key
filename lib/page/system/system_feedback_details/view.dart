import 'package:atoshi_key/common/model/feedback_details_model.dart';
import 'package:atoshi_key/common/res/q_color.dart';
import 'package:atoshi_key/common/res/q_string.dart';
import 'package:atoshi_key/common/utils/q_time.dart';
import 'package:atoshi_key/common/widget/bubble.dart';
import 'package:atoshi_key/common/widget/z_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SystemFeedbackDetailsPage extends GetView<SystemFeedbackDetailsLogic> {
  const SystemFeedbackDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return QScaffold(
          backgroundColor: QColor.white,
          title: QString.feedbackDetails.tr,
          body: ListView.builder(
              itemCount: controller.detailsList.length,
              itemBuilder: (context, index) {
                FeedbackDetailsInfo item = controller.detailsList[index];
                if (item.parentId == 0) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Bubble(
                                direction: BubbleDirection.right,
                                color: QColor.colorBlue,
                                child: Text(
                                  item.description!,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              buildDescTitle(
                                  title: timeDisplayFormat(item.createTime!))
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 30.w,
                          width: 30.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: QColor.colors535353,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '用户',
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(
                        left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30.w,
                          width: 30.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: QColor.colors8e8e8e,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '客服',
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Bubble(
                                direction: BubbleDirection.left,
                                color: QColor.colorBlue,
                                child: Text(
                                  item.description!,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              buildDescTitle(
                                  title: timeDisplayFormat(item.createTime!))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }));
    });
  }
}
