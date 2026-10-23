import Foundation

struct GetRandomEmojiUseCase {
    private let repository: EmojiRepositoryProtocol
    
    init(repository: EmojiRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<RandomEmoji, Error> {
        do {
            let result = try await repository.fetchEmojis()
            
            guard let randomEmoji = result.randomElement() else {
                return .failure(NSError(domain: "EmojiError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Emoji not Found"]))
            }
            let emoji: Emoji = Emoji(name: randomEmoji.key, urlString: randomEmoji.value)
            
            let imageData = try await repository.fetchImageData(urlString: emoji.urlString)
            
            return .success(RandomEmoji(emoji: emoji, imageData: imageData))
        } catch {
            return .failure(error)
        }
    }
}
