import Foundation

protocol AppleReposRepositoryProtocol {
    func fetchAppleRepos(page: Int, perPage: Int) async throws -> [AppleRepo]
}
