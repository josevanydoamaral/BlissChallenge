import Foundation

class AppContainer {
    @MainActor func makeFetchEmojisViewModel() -> HomeViewModel {
        let repository: EmojiRepositoryProtocol = EmojiRepository()
        let useCase: FetchEmojisUseCase = FetchEmojisUseCase(repository: repository)
        return HomeViewModel(useCase: useCase)
    }
}
