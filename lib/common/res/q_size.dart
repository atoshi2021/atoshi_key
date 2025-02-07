import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 文本字体大小设置
/// 1/文本字体大小统一规范，禁止出现单数
/// 2/弧度，使用3/5/10/20
/// 3/边界设置，等于页面整体内边距，统一风格，不允许修改
/// 4/其它间距：空间Widget之间的间距，统一，使用space，整体app统一，不允许修改
/// 5/其它编剧：各自内容各自编写
class QSize {
  static double get screenW => ScreenUtil().screenWidth;

  /// 标题字体大小
  static double title18 = 18.sp;

  /// 副标题字体大小
  static double secondTitle15 = 15.sp;

  /// 副标题字体大小
  static double buttonTitle14 = 14.sp;

  /// 副标题字体大小
  static double buttonTitle16 = 16.sp;

  static double iconArrowSize = 15.w;

  /// button 高度
  static double buttonHeight = 44.w;

  /// 小按钮高度
  static double smallButtonHeight = 35.w;

  /// 内容字体大小
  static double desc12 = 12.sp;
  static double desc11 = 11.sp;

  static double font10 = 10.sp;
  static double font13 = 13.sp;
  static double font14 = 14.sp;
  static double font15 = 15.sp;
  static double font16 = 16.sp;
  static double font18 = 18.sp;
  static double font20 = 20.sp;
  static double font26 = 26.sp;
  static double font32 = 32.sp;

  /// 行高
  static double lineHeight1_5 = 1.5.w;

  /// 圆角弧度
  static double r3 = 3.r;
  static double r5 = 5.r;
  static double r10 = 10.r;
  static double r15 = 15.r;
  static double r20 = 20.r;
  static double r25 = 25.r;
  static double r30 = 30.r;

  /// 页面padding 统一设定15个单位
  static double boundaryPage15 = 15.w;
  static double boundaryDialog50 = 50.w;
  static double space0 = 0.w;
  static double space1 = 1.w;
  static double space2 = 2.w;
  static double space3 = 3.w;
  static double space5 = 5.w;
  static double space8 = 8.w;
  static double space10 = 10.w;
  static double space12 = 12.w;
  static double space15 = 15.w;
  static double space16 = 16.w;
  static double space20 = 20.w;
  static double space24 = 24.w;
  static double space25 = 25.w;
  static double space30 = 30.w;
  static double space40 = 40.w;
  static double space44 = 44.w;
  static double space50 = 50.w;
  static double space60 = 60.w;
  static double space70 = 70.w;
  static double space80 = 80.w;
  static double space90 = 90.w;
  static double space100 = 100.w;
  static double space122 = 122.w;
  static double space150 = 150.w;
  static double space180 = 180.w;
  static double space190 = 190.w;

  static double space200 = 200.w;
  static double space250 = 250.w;
  static double space270 = 270.w;
  static double space280 = 280.w;
  static double spaceMineHeight = 220.w;
  static double space300 = 300.w;
  static double space400 = 400.w;
  static double space450 = 450.w;

  static double space550 = 550.w;
}
