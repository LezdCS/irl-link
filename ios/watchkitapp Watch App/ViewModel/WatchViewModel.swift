import Foundation
import WatchConnectivity

struct Message: Identifiable, Hashable, Decodable {
    var id = UUID()
    var username: String
    var message: String
    var color: String
    var badges: Array<String>
    
    enum CodingKeys: String, CodingKey {
        case badges, color, message, username
    }
    
    init(username: String, message: String, color: String, badges: [String] ) {
        self.username = username
        self.message = message
        self.color = color
        self.badges = badges
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the badges field as a string first
        let badgesString = try container.decode(String.self, forKey: .badges)
        
        // Convert the badges string (which is JSON format) to an actual array of strings
        if let data = badgesString.data(using: .utf8) {
            self.badges = (try? JSONDecoder().decode([String].self, from: data)) ?? []
        } else {
            self.badges = []
        }
        
        // Decode other fields
        self.color = try container.decode(String.self, forKey: .color)
        self.message = try container.decode(String.self, forKey: .message)
        self.username = try container.decode(String.self, forKey: .username)
    }
}


class WatchViewModel: NSObject, ObservableObject {
    var session: WCSession
    @Published var messages: [Message] = []
    @Published var viewers: Int = 0
    @Published var isLive: Bool = false
    
    // Add more cases if you have more receive method
    enum WatchReceiveMethod: String {
        case sendChatMessageToNative
    }
    
    // Add more cases if you have more sending method
    enum WatchSendMethod: String {
        case sendCounterToFlutter
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
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
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
