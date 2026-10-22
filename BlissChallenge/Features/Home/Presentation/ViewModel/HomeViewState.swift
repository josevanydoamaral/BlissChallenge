import Foundation

enum ActionState {
    case idle
    case loading
    case success
    case failure(String)
}


struct HomeViewState {
    var emojiState: ActionState = .idle
}
