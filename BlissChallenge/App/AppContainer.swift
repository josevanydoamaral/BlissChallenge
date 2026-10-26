import Foundation

class AppContainer {
    @MainActor func makeFetchEmojisViewModel() -> FetchEmojisViewModel {
        let repository: EmojiRepositoryProtocol = EmojiRepository()
        let useCase: FetchEmojisUseCase = FetchEmojisUseCase(repository: repository)
        return FetchEmojisViewModel(useCase: useCase)
    }
    
    
    @MainActor func makeHomeViewModel() -> HomeViewModel {
        let httpService: HTTPClientProtocol = HTTPClient()
        let storageService: UserStorageServiceProtocol = UserStorageService()
        
        let emojiRepository: EmojiRepositoryProtocol = EmojiRepository()
        
        let userRepository: UserRepositoryProtocol = UserRepository(httpService: httpService, storageService: storageService as! UserStorageService)
        
        let getRandomEmojiUseCase: GetRandomEmojiUseCase = GetRandomEmojiUseCase(repository: emojiRepository)
        
        let fetchUserUserCase: FetchUserUserCase = FetchUserUserCase(repository: userRepository as! UserRepository)
        
        return HomeViewModel(emojiUseCase: getRandomEmojiUseCase, userUseCase: fetchUserUserCase)
    }
    
    @MainActor func makeUsersViewModel() -> UsersViewModel {
        let httpService: HTTPClientProtocol = HTTPClient()
        let storageService: UserStorageServiceProtocol = UserStorageService()
        
        let userRepository: UserRepositoryProtocol = UserRepository(httpService: httpService, storageService: storageService as! UserStorageService)
        
        let fetchUsersUseCase: FetchUsersUseCase = FetchUsersUseCase(repository: userRepository as! UserRepository)
        
        let deleteUserUseCase: DeleteUserUseCase = DeleteUserUseCase(repository: userRepository as! UserRepository)
        
        return UsersViewModel(useCase: fetchUsersUseCase, deleteUseCase: deleteUserUseCase)
    }
}
