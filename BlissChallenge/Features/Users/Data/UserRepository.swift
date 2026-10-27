import Foundation

final class UserRepository: UserRepositoryProtocol {
    private let httpService: HTTPClientProtocol
    private let storageService: UserStorageService
    
    init(httpService: HTTPClientProtocol, storageService: UserStorageService) {
        self.httpService = httpService
        self.storageService = storageService
    }
    
    func fetchUser(searchTerm: String) async throws -> Bool {
        guard let cachedUser = try storageService.getUser(searchTerm: searchTerm) else {
            let url = "https://api.github.com/users/\(searchTerm)"
            let data = try await httpService.get(url: url)
            
            let userDTO = try JSONDecoder().decode(UserDTO.self, from: data)
            
            let imageData = try await httpService.getImage(from: userDTO.stringURL)
            
            let user = User(username: userDTO.username, imageData: imageData)
            
            try storageService.save(user: user)
            
            return true
        }
        
        return true
        
        
    }
    
    func fetchUsers() async throws -> [User] {
        let cachedUsers = try storageService.get()
        
        return cachedUsers
    }
    
    func deleteUser(user: User) async throws -> Bool {
        try await storageService.delete(user: user)
        return true
    }
    
    
    
    
    
    
}
