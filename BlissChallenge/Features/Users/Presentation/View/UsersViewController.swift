import Foundation
import UIKit

final class UsersViewController: UIViewController {
    let viewModel: UsersViewModel
    var users: [User] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewFlowLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
      
        
        return collectionView
    }()
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recently Searched users \(users.count)"
        
        setupUI()
        setupData()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        collectionView.register(UserGridCell.self, forCellWithReuseIdentifier: UserGridCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    func setupData() {
        viewModel.OnStateChange = {[weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loading:
                print("")
            case .success(let users):
                self.users = users
                collectionView.reloadData()
            case .failure(let errorMessage):
                print("Error Message")
            }
        }
        
        Task {
            await self.viewModel.getUsers()
        }
    }
    
    func makeCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        
        return layout
    }
    
}

extension UsersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(users.count)
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserGridCell.reuseIdentifier, for: indexPath) as! UserGridCell
        
        let user = users[indexPath.item]
        
        cell.configure(with: user)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = users[indexPath.item]
        
        users.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
        
        
        Task {
            await self.viewModel.deleteUser(user: user)
        }
        
    }
    
    
}


#Preview {
    let httpClient = HTTPClient()
    let storageService = UserStorageService()
    let repository = UserRepository(httpService: httpClient, storageService: storageService)
    let useCase = FetchUsersUseCase(repository: repository)
    let deleteUseCase = DeleteUserUseCase(repository: repository)
    let viewModel = UsersViewModel(useCase: useCase, deleteUseCase: deleteUseCase)
    return UINavigationController(rootViewController: UsersViewController(viewModel: viewModel))
}
