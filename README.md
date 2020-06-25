# alibaichuan

阿里百川SDK

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


#### ios pod 问题
flutter clean
rm -Rf ios/Pods
rm -Rf ios/.symlinks
rm -Rf ios/Flutter/Flutter.framework
rm -Rf ios/Flutter/Flutter.podspec

#### ios 百川sdk 
podfile文件追加


source 'http://repo.baichuan-ios.taobao.com/baichuanSDK/AliBCSpecs.git'

pod 'AlibcTradeSDK','4.0.0.8'
pod 'AliAuthSDK','2.0.0.3'
pod 'mtopSDK','3.0.0.4'
pod 'securityGuard','5.4.173'
pod 'AliLinkPartnerSDK','4.0.0.24'
pod 'BCUserTrack','5.2.0.11-appkeys'
pod 'UTDID','1.1.0.16'