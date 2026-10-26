
import Foundation


struct FetchUsersUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[User], Error> {
        do {
            let result = try await repository.fetchUsers()
            
            return .success(result)

        } catch {
            return .failure(error)
        }
    }
}
