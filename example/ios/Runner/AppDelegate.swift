import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    
   
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
//  private func receiveBatteryLevel(result: FlutterResult) {
//    let device = UIDevice.current
//    device.isBatteryMonitoringEnabled = true
//    print("调用百川----getBatteryLevel")
//    
//    if device.batteryState == UIDevice.BatteryState.unknown {
//      
//      result(FlutterError(code: "UNAVAILABLE",
//                          message: "Battery info unavailable",
//                          details: nil))
//    } else {
//      result(Int(device.batteryLevel * 100))
//    }
//  }
}
