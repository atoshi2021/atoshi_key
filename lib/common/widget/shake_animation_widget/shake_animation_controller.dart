///lib/demo/shake/shake_animation_controller.dart
///抖动监听
typedef ShakeAnimationListener = void Function(bool isOpen, int shakeCount);

///抖动动画控制器
class ShakeAnimationController {
  ///当前抖动动画的状态
  bool animationRunning = false;

  ///监听
  ShakeAnimationListener? _shakeAnimationListener;

  ///控制器中添加监听
  setShakeListener(ShakeAnimationListener listener) {
    _shakeAnimationListener = listener;
  }

  ///打开
  void start({int shakeCount = 1}) {
    if (_shakeAnimationListener != null) {
      animationRunning = true;
      _shakeAnimationListener!(true, shakeCount);
    }
  }

  ///关闭
  void stop() {
    if (_shakeAnimationListener != null) {
      animationRunning = false;
      _shakeAnimationListener!(false, 0);
    }
  }

  ///移除监听
  void removeListener() {
    _shakeAnimationListener = null;
  }
}