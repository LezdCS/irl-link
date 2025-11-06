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
      // Register plugins first
      GeneratedPluginRegistrant.register(with: self)

      FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

      // For flutter_foreground_task
      SwiftFlutterForegroundTaskPlugin.setPluginRegistrantCallback(registerPlugins)

      // Set up notification delegate
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
      }

      // Initialize Watch Connectivity
      if WCSession.isSupported() {
        session = WCSession.default
        session?.delegate = self
        session?.activate()
      }

      // Initialize Flutter channel after super call to ensure window is ready
      let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
      
      // Delay channel initialization to ensure window is ready
      DispatchQueue.main.async { [weak self] in
        self?.initFlutterChannel()
      }
      
      return result
  }
    
    private func initFlutterChannel() {
        guard let controller = window?.rootViewController as? FlutterViewController else {
            // Window not ready yet, try again later
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.initFlutterChannel()
            }
            return
        }
        
        let channel = FlutterMethodChannel(
            name: "com.irllink",
            binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler({ [weak self] (
            call: FlutterMethodCall,
            result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "flutterToWatch":
                guard let watchSession = self?.session, 
                      watchSession.isPaired, 
                      watchSession.isReachable, 
                      let methodData = call.arguments as? [String: Any], 
                      let method = methodData["method"], 
                      let data = methodData["data"] else {
                    print("Watch is not reachable")
                    result(false)
                    return
                }
                
                let watchData: [String: Any] = ["method": method, "data": data]
                
                // Pass the receiving message to Apple Watch
                watchSession.sendMessage(watchData, replyHandler: nil, errorHandler: { error in
                    print("Error sending message to watch: \(error.localizedDescription)")
                })
                result(true)
            default:
                result(FlutterMethodNotImplemented)
            }
        })
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

