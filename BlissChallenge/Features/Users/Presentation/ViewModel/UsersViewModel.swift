import Foundation

@MainActor
final class UsersViewModel {
    let useCase: FetchUsersUseCase
    let deleteUseCase: DeleteUserUseCase
    
    var OnStateChange: ((UsersViewState) -> Void)?
    
    private(set) var state: UsersViewState = .loading {
        didSet {
            OnStateChange?(state)
        }
    }
    
    init(useCase: FetchUsersUseCase, deleteUseCase: DeleteUserUseCase) {
        self.useCase = useCase
        self.deleteUseCase = deleteUseCase
    }
    
    func getUsers() async {
        state = .loading
        
        let result = await useCase.execute()
        
        switch result {
        case .success(let users):
            state = .success(users)
        case .failure(let error):
            state = .failure(error.localizedDescription)
        }
    }
    
    func deleteUser(user: User) async {
        state = .loading
        
        await deleteUseCase.execute(user: user)
        
        await getUsers()
        
    }
}

