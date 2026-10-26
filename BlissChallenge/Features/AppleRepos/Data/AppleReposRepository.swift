import Foundation

final class AppleReposRepository: AppleReposRepositoryProtocol {
    let httpService: HTTPClient
    
    init(httpService: HTTPClient) {
        self.httpService = httpService
    }
    
    func fetchAppleRepos(page: Int, perPage: Int) async throws -> [AppleRepo] {
        let data = try await httpService.get(url: "https://api.github.com/users/apple/repos?page=\(page)&per_page=\(perPage)")
        
        let appleReposDTO: [AppleRepoDTO] = try JSONDecoder().decode([AppleRepoDTO].self, from: data)
        
        let appleRepos: [AppleRepo] = appleReposDTO.map({
            AppleRepo(id: $0.id, name: $0.name, description: $0.description)
        })
        
        return appleRepos
        
    }
    
    
}
