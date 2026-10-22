import Foundation

@MainActor
class HomeViewModel {
    let useCase: FetchEmojisUseCase
    
    init(useCase: FetchEmojisUseCase) {
        self.useCase = useCase
    }
    
    
}
