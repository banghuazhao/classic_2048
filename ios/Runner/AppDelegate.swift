import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let adChannel = FlutterMethodChannel(name: "com.appsbay.classic_2048/ads",
                                          binaryMessenger: controller.binaryMessenger)
    adChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if (call.method == "getAdUnitIds") {
        let bannerId = Bundle.main.object(forInfoDictionaryKey: "AdMobBannerID") as? String ?? ""
        let appOpenId = Bundle.main.object(forInfoDictionaryKey: "AdMobAppOpenID") as? String ?? ""
        result([
          "banner": bannerId,
          "appOpen": appOpenId
        ])
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
