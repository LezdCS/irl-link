import UIKit
import Flutter
import WatchConnectivity

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // For flutter_foreground_task
    SwiftFlutterForegroundTaskPlugin.setPluginRegistrantCallback(registerPlugins)

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let watchConnectivityChannel = FlutterMethodChannel(name: "watch_connectivity_channel",
                                                        binaryMessenger: controller.binaryMessenger)

    watchConnectivityChannel.setMethodCallHandler {
      (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "sendMessageToWatch" {
        if let args = call.arguments as? [String: Any],
           let message = args["message"] as? String {
          self.sendMessageToWatch(message: message)
          result("Message sent")
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Message not found", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func sendMessageToWatch(message: String) {
    if WCSession.isSupported() {
      let session = WCSession.default
      if session.isReachable {
        session.sendMessage(["message": message], replyHandler: nil) { error in
          print("Error sending message: \(error.localizedDescription)")
        }
      }
    }
  }
}

// For flutter_foreground_task
func registerPlugins(registry: FlutterPluginRegistry) {
  GeneratedPluginRegistrant.register(with: registry)
}
