import Foundation

class UserInfo: Codable {
    var name: String
    var gender: String
    var address: String
    
    init(name: String, gender: String, address: String) {
        self.name = name
        self.gender = gender
        self.address = address
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard
            let name = dictionary["name"] as? String,
            let gender = dictionary["gender"] as? String,
            let address = dictionary["address"] as? String
        else {
            return nil
        }
        self.init(name: name, gender: gender, address: address)
    }
}

extension UserInfo {
    func update(name: String? = nil, gender: String? = nil, address: String? = nil) {
        if let name = name {
            self.name = name
        }
        if let gender = gender {
            self.gender = gender
        }
        if let address = address {
            self.address = address
        }
    }

    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        let dictionary = json as! [String: Any]
        return dictionary
    }
}
