import Foundation

enum EmojisViewState {
    case loading
    case success([Emoji])
    case failure(String)
}
