import Foundation

enum ActionState {
    case idle
    case loading
    case success
    case failure(String)
}


struct HomeViewState {
    var emojiState: ActionState = .idle
    var randomEmoji: RandomEmoji?
    
    var userState: ActionState = .idle
}
