import Foundation

@MainActor
class HomeViewModel {
    private let emojiUseCase: GetRandomEmojiUseCase
    private let userUseCase: FetchUserUserCase
    
    var OnStateChange: ((HomeViewState) -> Void)?
    
    private(set) var state = HomeViewState() {
        didSet {
            OnStateChange?(state)
        }
    }
    
    init(emojiUseCase: GetRandomEmojiUseCase, userUseCase: FetchUserUserCase) {
        self.emojiUseCase = emojiUseCase
        self.userUseCase = userUseCase
    }
    
    func getRandomEmoji() async {
        state.emojiState = .loading
        
        let result = await emojiUseCase.execute()
        
        switch result {
        case .success(let randomEmoji):
            state.emojiState = .success
            state.randomEmoji = randomEmoji
        case.failure(let error):
            state.emojiState = .failure(error.localizedDescription)
        }
    }
    
    func getUser(searhTerm: String) async {
        state.userState = .loading
        
        let result = await userUseCase.execute(searchTerm: searhTerm)
        
        switch result {
        case .success(_):
            state.userState = .success
        case .failure(let error):
            state.userState = .failure(error.localizedDescription)
        }
    }
    
}
