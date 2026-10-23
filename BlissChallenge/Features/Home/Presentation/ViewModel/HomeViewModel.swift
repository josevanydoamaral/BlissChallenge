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
    
    func getRadomEmoji() async {
        
    }
    
}
