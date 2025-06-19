import Foundation
import WatchConnectivity

struct ObsSource: Hashable, Decodable {
    var sceneItemId: Int
    var sceneItemEnabled: Bool
    var sourceName: String
}

struct SeActivity: Hashable, Decodable {
    var id: String
    var message: String
    var text: String
    var username: String
    var colors: Array<Int64>
}

class WatchViewModel: NSObject, ObservableObject {
    var session: WCSession
    @Published var messages: [Message] = []
    @Published var viewers: Int = 0
    @Published var isLive: Bool = false
    
    @Published var obsConnected: Bool = false
    @Published var selectedScene: String = ""
    @Published var scenes: [String] = []
    @Published var sources: [ObsSource] = []
    
    @Published var seConnected: Bool = false
    @Published var seActivities: [SeActivity] = []
    
    // Add more cases if you have more receive method
    enum WatchReceiveMethod: String {
        case sendChatMessageToNative
        case sendViewersToNative
        case sendLiveStatusToNative
        
        case sendUpdateObsConnecteToNative
        case sendSelectedObsSceneToNative
        case sendObsScenesToNative
        case sendObsSourcesToNative
        
        case sendSeConnectedToNative
        case sendSeActivityToNative
    }
    
    // Add more cases if you have more sending method
    enum WatchSendMethod: String {
        case sendChangeObsSceneToFlutter
        case sendToggleObsSourceToFlutter
    }
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func sendDataMessage(for method: WatchSendMethod, data: [String: Any] = [:]) {
        sendMessage(for: method.rawValue, data: data)
    }
}

extension WatchViewModel: WCSessionDelegate {
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle session activation completion
        if let error = error {
            print("WC Session activation failed with error: \(error.localizedDescription)")
            return
        }
        print("WC Session activated with state: \(activationState.rawValue)")
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        // Required for iOS only
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Required for iOS only
        session.activate()
    }
    #endif
    
    // Receive message From AppDelegate.swift that send from iOS devices
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            guard let method = message["method"] as? String, let enumMethod = WatchReceiveMethod(rawValue: method) else {
                return
            }
            
            switch enumMethod {
            case .sendChatMessageToNative:
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: message["data"]!, options: [])
                    do {
                        let msg = try JSONDecoder().decode(Message.self, from: jsonData)
                        if(self.messages.contains(msg)) {
                            return
                        }
                        self.messages.append(msg)
                        if(self.messages.count > 10) {
                            self.messages.removeFirst()
                        }
                    } catch {
                        // Handle error
                        print("Error occurred: \(error)")
                    }
                } catch {
                    // Handle error
                    print("Error occurred: \(error)")
                }
            case .sendViewersToNative:
                self.viewers = message["data"] as! Int
            case .sendLiveStatusToNative:
                self.isLive = message["data"] as! Bool
            case .sendUpdateObsConnecteToNative:
                self.obsConnected = message["data"] as! Bool
            case .sendSelectedObsSceneToNative:
                self.selectedScene = message["data"] as! String
            case .sendObsScenesToNative:
                self.scenes = message["data"] as! [String]
            case .sendObsSourcesToNative:
                do {
                    let jsonString = message["data"] as! String
                    let jsonData = jsonString.data(using: .utf8)!
                    let obsSources: [ObsSource] = try JSONDecoder().decode([ObsSource].self, from: jsonData)
                    self.sources = obsSources
                } catch {
                    print("Error encoding string to JSON: \(error)")
                }
                
            case .sendSeConnectedToNative:
                self.seConnected = message["data"] as! Bool
            case .sendSeActivityToNative:
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: message["data"]!, options: [])
                    do {
                        let seActivity = try JSONDecoder().decode(SeActivity.self, from: jsonData)
                        if(self.seActivities.contains(seActivity)) {
                            return
                        }
                        self.seActivities.append(seActivity)
                    } catch {
                        // Handle error
                        print("Error occurred: \(error)")
                    }
                } catch {
                    // Handle error
                    print("Error occurred: \(error)")
                }
            }
        }
    }
    
    func sendMessage(for method: String, data: [String: Any] = [:]) {
        guard session.isReachable else {
            print("ios not reachable")
            return
        }
        let messageData: [String: Any] = ["method": method, "data": data]
        print("sending data to ios")
        session.sendMessage(messageData, replyHandler: nil, errorHandler: nil)
    }
}
