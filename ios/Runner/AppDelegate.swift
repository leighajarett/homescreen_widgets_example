import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let containerChannel = FlutterMethodChannel(name: "example.widget.dev/get_container_path",
                                              binaryMessenger: controller.binaryMessenger)

    containerChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // This method is invoked on the UI thread.
      guard call.method == "getContainerPath" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.getContainerPath(call: call, result: result)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getContainerPath(call: FlutterMethodCall, result: FlutterResult) {
    if let args = call.arguments as? Dictionary<String, Any>{
      if let appGroup = args["appGroup"] as? String{
        let containerPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)?.path
        result(containerPath)
      }
    }else {
      result(FlutterError(code: "UNAVAILABLE",
                          message: "No app group",
                          details: nil))
    }
  }


}

