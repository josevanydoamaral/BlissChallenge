import Foundation

struct FetchEmojisUseCase {
    private let repository: EmojiRepositoryProtocol
    
    init(repository: EmojiRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<EmojisDictionary, Error> {
        // Try to fall function to fetch data
        do {
            let result = try await repository.fetchEmojis()
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
