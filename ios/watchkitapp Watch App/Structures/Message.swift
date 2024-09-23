import Foundation

struct Message: Hashable, Decodable {
    var id: String
    var username: String
    var message: String
    var color: String
    var badges: Array<String>
    
    enum CodingKeys: String, CodingKey {
        case id, badges, color, message, username
    }
    
    init(id: String, username: String, message: String, color: String, badges: [String] ) {
        self.id = id
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
        self.id = try container.decode(String.self, forKey: .id)
    }
}
