import Foundation

struct DeleteUserUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(user: User) async -> Result<Bool, Error> {
        do {
            let result = try await repository.deleteUser(user: user)
            
            return .success(result)

        } catch {
            return .failure(error)
        }
    }
}
