import Foundation
import UIKit
import SwiftUI

final class EmojisViewController: UIViewController {
    private let viewModel: FetchEmojisViewModel
    private var emojis: [Emoji] = []
    private let refreshControl = UIRefreshControl()
    
    private lazy var collectionView: UICollectionView = {
        let layout = makeCollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    init(viewModel: FetchEmojisViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emojis"
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupData()
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 32
        layout.minimumLineSpacing = 32
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        layout.itemSize = CGSize(width: 60, height: 60)
        return layout
    }
    
    
    func setupUI() {
        collectionView.register(EmojiGridCell.self, forCellWithReuseIdentifier: EmojiGridCell.reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    
    func setupData() {
        viewModel.OnStateChange = {[weak self] state in
            guard let self = self else { return }
            print("onStateChange")
            
            switch state {
            case .success(let emojis):
                DispatchQueue.main.async {
                    print("success")
                    self.emojis = emojis
                    self.collectionView.reloadData()
                }
                
            case .failure(let messageError):
                print("\(messageError)")
            default:
                break
            }
        }

        Task {
            await viewModel.getEmojis()
        }
        
        refreshControl.addAction(UIAction {[weak self] _ in
            print("Action")
            guard let self = self else { return }
            self.handleRefresh()
            
        }, for: .valueChanged)
        
    }
    
    private func handleRefresh() {
        print("handleRefreshCalled")
        Task {
            await self.viewModel.getEmojis()
            refreshControl.endRefreshing()
            
        }
    }

}

extension EmojisViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(emojis.count)
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiGridCell.reuseIdentifier, for: indexPath) as! EmojiGridCell
        
        let emoji = emojis[indexPath.item]
        
        if let url = URL(string: emoji.urlString) {
            cell.configure(with: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        emojis.remove(at: indexPath.item)
        
        collectionView.deleteItems(at: [indexPath])
        
    }
    
    
    
}


#Preview {
    let repository = EmojiRepository()
    let useCase = FetchEmojisUseCase(repository: repository)
    let viewModel = FetchEmojisViewModel(useCase: useCase)
    return UINavigationController(rootViewController: EmojisViewController(viewModel: viewModel))
}

