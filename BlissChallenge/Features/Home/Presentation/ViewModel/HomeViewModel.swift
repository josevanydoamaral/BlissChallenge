import Foundation

@MainActor
class HomeViewModel {
    private let useCase: GetRandomEmojiUseCase
    
    var OnStateChange: ((HomeViewState) -> Void)?
    
    private(set) var state = HomeViewState() {
        didSet {
            OnStateChange?(state)
        }
    }
    
    init(useCase: GetRandomEmojiUseCase) {
        self.useCase = useCase
    }
    
    func getRandomEmoji() async {
        state.emojiState = .loading
        
        let result = await useCase.execute()
        
        switch result {
        case .success(let randomEmoji):
            state.emojiState = .success
            state.randomEmoji = randomEmoji
        case.failure(let error):
            state.emojiState = .failure(error.localizedDescription)
        }
    }
    
}
