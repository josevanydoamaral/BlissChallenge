import Foundation

enum AppleReposViewState {
    case loading
    case success([AppleRepo])
    case failure(String)
}
