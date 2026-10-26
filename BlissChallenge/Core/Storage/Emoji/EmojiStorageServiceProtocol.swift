import Foundation

protocol EmojiStorageServiceProtocol {
    func save(emojis: EmojisDictionary) throws 
    func get() throws -> EmojisDictionary
}
