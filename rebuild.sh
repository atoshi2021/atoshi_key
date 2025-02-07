rm -rf pubspec.lock
rm -rf ios/.symlinks
rm -rf ios/Pods
rm -rf ios/Podfile.lock
flutter clean
flutter pub get
# shellcheck disable=SC2164
cd ios
pod install
# shellcheck disable=SC2103
cd ..