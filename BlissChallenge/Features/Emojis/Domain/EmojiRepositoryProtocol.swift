import Foundation

protocol EmojiRepositoryProtocol {
    func fetchEmojis() async throws -> EmojisDictionary
    func fetchImageData(urlString: String) async throws -> Data
}
