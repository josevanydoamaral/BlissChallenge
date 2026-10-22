import Foundation

protocol EmojiRepositoryProtocol {
    func fetchEmojis() async throws -> EmojisDictionary
}
