import Foundation

@MainActor
final class AppleReposViewModel {
    private let useCase: FetchAppleReposUseCase
    
    private var repos:[AppleRepo] = []
    private var currentPage: Int = 1
    private var canLoadMore: Bool = true
    
    var OnStateChange: ((AppleReposViewState) -> Void)?
    
    private(set) var state: AppleReposViewState = .loading {
        didSet {
            OnStateChange?(state)
        }
    }
    
    init(useCase: FetchAppleReposUseCase) {
        self.useCase = useCase
    }
    
    func getAppleRepos() async {
        state = .loading
        
        let result = await useCase.execute(page: currentPage, perPage: 10)
        
        switch result {
        case .success(let newRepos):
            repos.append(contentsOf: newRepos)
            state = .success(repos)
        case .failure(let error):
            state = .failure(error.localizedDescription)
        }
        
        self.currentPage += 1
    }
}
