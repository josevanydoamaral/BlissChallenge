import Foundation

struct FetchAppleReposUseCase {
    let repository: AppleReposRepository
    
    init(repository: AppleReposRepository) {
        self.repository = repository
    }
    
    func execute(page: Int, perPage: Int = 10) async -> Result<[AppleRepo], Error> {
        do {
            let result = try await repository.fetchAppleRepos(page: page, perPage: perPage)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
