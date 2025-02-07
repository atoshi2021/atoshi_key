# atoshi_key

A new Flutter project of Atoshi key

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 通过这个方式可以写入渠道

# flutter build apk --build-name="${versionName}" --build-number="${versionNumber}" --dart-define=channel="${channel}"

# static const channel = String.fromEnvironment('channel', defaultValue: '');
