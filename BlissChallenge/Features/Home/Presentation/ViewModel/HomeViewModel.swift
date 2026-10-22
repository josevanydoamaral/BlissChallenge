import Foundation

@MainActor
class HomeViewModel {
    let useCase: FetchEmojisUseCase
    
    /*
    var OnStateChange: ((HomeViewState) -> Void)?
    
    private(set) var state = HomeViewState() {
        didSet {
            OnStateChange?(state)
        }
    }
     */
    
    var OnStateChange: ((EmojisViewState) -> Void)?
    
    private(set) var state: EmojisViewState = .loading {
        didSet {
            OnStateChange?(state)
        }
    }
    
    init(useCase: FetchEmojisUseCase) {
        self.useCase = useCase
    }
    
    func getEmojis() async {
        state = .loading
        
        let result = await useCase.execute()
        
        switch result {
        case .success(let emojisDictionary):
            let emojis: [Emoji] = emojisDictionary.map { Emoji(name: $0.key, urlString: $0.value) }
            state = .success(emojis)
        case .failure(let errorMessage):
            state = .failure(errorMessage.localizedDescription)
        }
        
    }
    
    
}
