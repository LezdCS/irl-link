import UIKit
import Flutter
import WatchConnectivity
import flutter_downloader

@main
@objc class AppDelegate: FlutterAppDelegate {
    var session: WCSession?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      initFlutterChannel()
      if WCSession.isSupported() {
        session = WCSession.default;
        session?.delegate = self;
        session?.activate();
      }
    GeneratedPluginRegistrant.register(with: self)

    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

    // For flutter_foreground_task
    SwiftFlutterForegroundTaskPlugin.setPluginRegistrantCallback(registerPlugins)

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func initFlutterChannel() {
            if let controller = window?.rootViewController as? FlutterViewController {
                let channel = FlutterMethodChannel(
                    name: "com.irllink",
                    binaryMessenger: controller.binaryMessenger)
                
                channel.setMethodCallHandler({ [weak self] (
                    call: FlutterMethodCall,
                    result: @escaping FlutterResult) -> Void in
                    switch call.method {
                    case "flutterToWatch":
                        guard let watchSession = self?.session, watchSession.isPaired, watchSession.isReachable, let methodData = call.arguments as? [String: Any], let method = methodData["method"], let data = methodData["data"] else {
                            print("Watch is not reachable")
                            result(false)
                            return
                        }
                        
                        let watchData: [String: Any] = ["method": method, "data": data]
                        
                        // Pass the receiving message to Apple Watch
                        watchSession.sendMessage(watchData, replyHandler: nil, errorHandler: nil)
                        result(true)
                    default:
                        result(FlutterMethodNotImplemented)
                    }
                })
            }
        }
}

extension AppDelegate: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let method = message["method"] as? String, let controller = self.window?.rootViewController as? FlutterViewController {
                let channel = FlutterMethodChannel(
                    name: "com.irllink",
                    binaryMessenger: controller.binaryMessenger)
                channel.invokeMethod(method, arguments: message)
            }
        }
    }
}

// For flutter_foreground_task
func registerPlugins(registry: FlutterPluginRegistry) {
  GeneratedPluginRegistrant.register(with: registry)
}

