import Foundation

struct UserDTO: Decodable {
    let username: String
    let stringURL: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case stringURL = "avatar_url"
    }
}
