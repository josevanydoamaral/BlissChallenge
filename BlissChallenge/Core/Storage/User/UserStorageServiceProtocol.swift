import Foundation

protocol UserStorageServiceProtocol {
    func get() throws -> [User]
    func getUser(searchTerm: String) throws -> User?
    func save(user: User) throws
    func delete(user: User) throws
}
