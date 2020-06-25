import Flutter
import UIKit

public class SwiftAlibaichuanPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "alibaichuan", binaryMessenger: registrar.messenger())
    let instance = SwiftAlibaichuanPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("调用方法名-->>\(call.method)")
    if call.method == "getPlatformVersion"{
      result("iOS " + UIDevice.current.systemVersion)
    }
  }
  
  public func initAli(){
    print("------百川SDK初始化失败")
//    AlibcTradeSDK.sharedInstance()
//    AlibcTradeSDK.sharedInstance()?.asyncInit(success:
//      {()->Void in
//        print("------百川SDK初始化成功")
//    }, failure: {(Error)-> Void in
//      print("------百川SDK初始化失败")
//
//    })

  }
  
}

