import Foundation

protocol UserRepositoryProtocol {
    func fetchUser(searchTerm: String) async throws -> Bool
    func fetchUsers() async throws -> [User]
    func deleteUser(user: User) async throws -> Bool
}
