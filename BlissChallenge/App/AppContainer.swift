import Foundation

class AppContainer {
    @MainActor func makeFetchEmojisViewModel() -> FetchEmojisViewModel {
        let repository: EmojiRepositoryProtocol = EmojiRepository()
        let useCase: FetchEmojisUseCase = FetchEmojisUseCase(repository: repository)
        return FetchEmojisViewModel(useCase: useCase)
    }
    
    @MainActor func makeHomeViewModel() -> HomeViewModel {
        let emojiRepository: EmojiRepositoryProtocol = EmojiRepository()
        let emojiUseCase: GetRandomEmojiUseCase = GetRandomEmojiUseCase(repository: emojiRepository)
        return HomeViewModel(useCase: emojiUseCase)
    }
}
