import Foundation

enum EmojisViewState {
    case loading
    case success(EmojisDictionary)
    case failure(String)
}
