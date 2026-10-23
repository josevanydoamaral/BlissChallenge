import Foundation

class EmojiRepository: EmojiRepositoryProtocol {
    func fetchImageData(urlString: String) async throws -> Data {
        <#code#>
    }
    
    let httpClient: HTTPClientProtocol
    let storageService: EmojiStorageServiceProtocol
    
    init(httpClient: HTTPClientProtocol = HTTPClient(), storageService: EmojiStorageServiceProtocol = EmojiStorageService()) {
        self.httpClient = httpClient
        self.storageService = storageService
    }
    
    func fetchEmojis() async throws -> EmojisDictionary {
        // Try to fetch emojis from cache first
        if let cachedEmojis = try? storageService.get(), !cachedEmojis.isEmpty {
            return cachedEmojis
        }
        
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
