import Foundation

struct FetchUserUserCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(searchTerm: String) async -> Result<Bool, Error> {
        do {
            let result = try await repository.fetchUser(searchTerm: searchTerm)
            
            return .success(result)

        } catch {
            return .failure(error)
        }
    }
}
