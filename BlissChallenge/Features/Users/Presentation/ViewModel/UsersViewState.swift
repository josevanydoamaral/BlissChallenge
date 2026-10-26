import Foundation

enum UsersViewState {
    case loading
    case success([User])
    case failure(String)
}
