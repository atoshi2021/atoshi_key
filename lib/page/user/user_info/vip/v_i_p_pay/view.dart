import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logic.dart';

class VIPPayPage extends GetView<VIPPayLogic> {
  const VIPPayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        isDefaultPadding: false,
        title: QString.commonMemberPay.tr,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPayPrice(),
            _buildPayTypeTitle(),
            Expanded(
              child: GetBuilder<VIPPayLogic>(
                id: controller.idPayType,
                assignId: true,
                builder: (logic) {
                  return ListView.separated(
                    itemCount: controller.payTypeList.length,
                    itemBuilder: (context, index) {
                      return _buildPayTypeItem(context, index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: QSize.space1,
                        color: QColor.bg,
                      );
                    },
                  );
                },
              ),
            ),
            _buildPayButton(),
          ],
        ));
  }

  Widget _buildPayTypeItem(BuildContext context, int index) {
    var item = controller.payTypeList[index];
    var method = item.method ?? -1;
    return InkWell(
      onTap: () => controller.changePayType(index),
      child: Container(
        color: QColor.white,
        padding: EdgeInsets.symmetric(
            horizontal: QSize.boundaryPage15, vertical: QSize.space5),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(QSize.space5)),
              child: loadImage(item.image ?? '',
                  width: QSize.space30, height: QSize.space30),
            ),
            QSpace(width: QSize.space10),
            buildSecondTitle(title: item.name ?? ''),
            const Spacer(),
            Visibility(
                visible: (method == 0 && (item.discount ?? -1) < 1),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: QSize.space5, vertical: QSize.space3),
                  decoration: BoxDecoration(
                      color: QColor.colorRed,
                      borderRadius: BorderRadius.circular(QSize.r3)),
                  child: (Constant.local != ALocaleType.localeTypeEn)
                      ? buildDescWhiteTitle(
                          title: QString.discountedPrice.tr.replaceFirst(
                              '%s', '${(item.discount ?? 0) * 10}'))
                      : buildDescWhiteTitle(
                          title: QString.discountedPrice.tr.replaceFirst(
                              '%s', '${100 - (item.discount ?? 0) * 100}%')),
                )),
            QSpace(width: QSize.space8),
            Radio(
                value: index,
                groupValue: controller.payIndex,
                onChanged: <int>(v) {
                  controller.changePayType(v);
                })
          ],
        ),
      ),
    );
  }

  _buildPayPrice() {
    // bool isFirst = true;
    // if (controller.payTypeList.isNotEmpty) {
    //   if (controller.payTypeList[controller.payIndex].price?.currency ==
    //       'ATOS') {
    //     isFirst = false;
    //   }
    // }
    // var unit = controller.payTypeList.isEmpty
    //     ? ' \$'
    //     : '${controller.payTypeList[controller.payIndex].price?.currency}';
    // var price =controller.payTypeList.isEmpty
    //     ? '${controller.skus[0].skuPrice}'
    //     : '${controller.payTypeList[controller.payIndex].price?.price}';
    return GetBuilder<VIPPayLogic>(
      id: controller.idPrice,
      assignId: true,
      builder: (logic) {
        double price = controller.payTypeList.isEmpty
            ? (controller.skus[0].skuPrice ?? 0.0)
            : (controller.payTypeList[controller.payIndex].price?.price ?? 0.0);
        if (controller.payTypeList.isNotEmpty &&
            controller.payTypeList[controller.payIndex].method == 0) {
           price = price*100;
               // _numToInt(price*100);
        }
        return Container(
          color: QColor.white,
          height: QSize.space100,
          child: Center(
            child: Text.rich(
              TextSpan(
                  text: !(controller.payTypeList.isNotEmpty &&
                          controller.payTypeList[controller.payIndex].price
                                  ?.currencySeat ==
                              2)
                      ? (controller.payTypeList.isEmpty
                          ? ' \$'
                          : '${controller.payTypeList[controller.payIndex].price?.currency}')
                      : _numToInt(price),
                  style: TextStyle(
                      color: QColor.colorRed,
                      fontSize: (controller.payTypeList.isNotEmpty &&
                              controller.payTypeList[controller.payIndex].price
                                      ?.currencySeat ==
                                  2)
                          ? QSize.font26
                          : QSize.font14),
                  children: [
                    TextSpan(
                        text: (controller.payTypeList.isNotEmpty &&
                                controller.payTypeList[controller.payIndex]
                                        .price?.currencySeat ==
                                    2)
                            ? (controller.payTypeList.isEmpty
                                ? ' \$'
                                : '${controller.payTypeList[controller.payIndex].price?.currency}')
                            : '$price',
                        style: TextStyle(
                            color: QColor.colorRed,
                            fontSize: !(controller.payTypeList.isNotEmpty &&
                                    controller.payTypeList[controller.payIndex]
                                            .price?.currencySeat ==
                                        2)
                                ? QSize.font26
                                : QSize.font14))
                  ]),
            ),
          ),
        );
      },
    );
  }

  //处理小数点
  _numToInt(double num) {
    var doubleIssString = double.parse(num.toString());
    String piAsString = doubleIssString.toStringAsFixed(1);
    return piAsString;
  }

  _buildPayTypeTitle() {
    return Container(
      width: QSize.screenW,
      margin: EdgeInsets.only(bottom: QSize.space1),
      padding: EdgeInsets.symmetric(
          horizontal: QSize.boundaryPage15, vertical: QSize.space10),
      color: QColor.white,
      child: buildSecondTitle(title: QString.commonPayment.tr),
    );
  }

  _buildPayButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
      margin: EdgeInsets.only(bottom: QSize.boundaryPage15),
      child: QButtonRadius(
        text: QString.commonBuy.tr,
        bgColor: QColor.colorBlue,
        textColor: QColor.white,
        callback: () async {
          var payMethod = controller.payTypeList[controller.payIndex].method;
          if (payMethod == 0) {
            var isBind = await controller.getBindAtoshiInfo();
            if (isBind) {
              var createOrder = await controller.createPayOrder();
              if (createOrder != -1) {
                showPayKeyboard(
                        paymentAccount: controller.getPaymentAccount().toString(),
                        password: controller.payPassword)
                    .then((value) {
                  if (value != null && (value is bool) && value) {
                    // 支付成功
                    Get
                      ..back()
                      ..back();
                  }
                });
              }
            } else {
              /// 去绑定账号
              AppRoutes.toNamed(AppRoutes.userSetBindAtoshiAccount)
                  .then((value) => controller.getRecordKey());
            }
          } else {
            var payMethod = await controller.createPayOrder();
            // 'payMethod:$payMethod'.toast();
            if (payMethod == 1) {
              /// 支付宝支付
              if (controller.outTradeNo != null &&
                  controller.outTradeNo!.isNotEmpty) {
                Constant.isChangeLock = false;
                controller.isNeedRequestH5PayResult = true;
                // AppRoutes.toNamed(AppRoutes.web,
                //         arguments: controller.qrCodeUrl ?? '')
                //     .then((value) => controller.queryOrder().then((result) {
                //           controller.delayedReState();
                //           if (result == 0) {
                //             Get
                //               ..back()
                //               ..back();
                //           }
                //         }));
                launchUrl(Uri.parse(controller.qrCodeUrl ?? ''),
                    mode: LaunchMode.externalApplication);
              }
            } else if (payMethod == 2) {
              /// 微信支付
              if (controller.outTradeNo != null &&
                  controller.outTradeNo!.isNotEmpty) {
                Constant.isChangeLock = false;
                controller.isNeedRequestH5PayResult = true;
                // AppRoutes.toNamed(AppRoutes.web,
                //         arguments: controller.qrCodeUrl ?? '')
                //     .then((value) => controller.queryOrder().then((result) {
                //           controller.delayedReState();
                //           if (result == 0) {
                //             Get
                //               ..back()
                //               ..back();
                //           }
                //         }));
                launchUrl(Uri.parse(controller.qrCodeUrl ?? ''),
                    mode: LaunchMode.externalApplication);
              }
            } else if (payMethod == 3) {
              // 'url:${controller.qrCodeUrl ?? ''}'.logW();
              Constant.isChangeLock = false;
              controller.isNeedRequestH5PayResult = true;
              launchUrl(Uri.parse(controller.qrCodeUrl ?? ''),
                  mode: LaunchMode.externalApplication);
              // AppRoutes.toNamed(AppRoutes.web,
              //         arguments: controller.qrCodeUrl ?? '')
              //     .then((value) => controller.queryOrder().then((result) {
              //           controller.delayedReState();
              //           if (result == 0) {
              //             Get
              //               ..back()
              //               ..back();
              //           }
              //         }));
              // paypal 支付
              // launchUrl(Uri.parse(controller.qrCodeUrl ?? ''))
              //     .then((value) => controller.queryOrder().then((result) {
              //           controller.delayedReState();
              //           if (result == 0) {
              //             Get
              //               ..back()
              //               ..back();
              //           }
              //         }));
            }
          }
        },
        radius: QSize.r3,
      ),
    );
  }
}
