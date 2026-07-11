import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let adChannel = FlutterMethodChannel(
      name: "com.appsbay.classic_2048/ads",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    adChannel.setMethodCallHandler { call, result in
      guard call.method == "getAdUnitIds" else {
        result(FlutterMethodNotImplemented)
        return
      }
      result([
        "banner": Bundle.main.object(forInfoDictionaryKey: "AdMobBannerID") as? String ?? "",
        "appOpen": Bundle.main.object(forInfoDictionaryKey: "AdMobAppOpenID") as? String ?? "",
      ])
    }
  }
}
