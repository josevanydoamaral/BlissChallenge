import Foundation

class EmojiRepository: EmojiRepositoryProtocol {
    let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func fetchEmojis() async throws -> EmojisDictionary {
        // Call NetworkService
        let data = try await httpClient.get(url: "https://api.github.com/emojis")
        
        // Json Decode
        guard let emojis = try? JSONDecoder().decode(EmojisDictionary.self, from: data) else {
            throw NetworkError.decodedError
        }
        
        
        // Return it as a EmojisDictionary
        return emojis
    }
    
    
}
