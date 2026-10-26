import Foundation
import UIKit
import SwiftUI

final class AppleReposViewController: UIViewController {
    let viewModel: AppleReposViewModel
    
    var appleRepos: [AppleRepo] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.isHidden = true
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    init(viewModel: AppleReposViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(errorLabel)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate =  self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AppleReposCell")
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: errorLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupData() {
        viewModel.OnStateChange = {[weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loading:
                print("Loading")
            case .success(let allRepos):
                self.appleRepos = allRepos
                tableView.reloadData()
            case .failure(let errorMessage):
                errorLabel.isHidden = false
                errorLabel.text = errorMessage
                
            }
            
        }
        
        Task {
            await viewModel.getAppleRepos()
        }
    }
}


extension AppleReposViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppleReposCell", for: indexPath)
        
        let item = appleRepos[indexPath.row]
        
        var repository = cell.defaultContentConfiguration()
        repository.text = item.name
        
        cell.contentConfiguration = repository
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == appleRepos.count-1 {
            Task {
                await viewModel.getAppleRepos()
            }
        }
    }
    
    
}

#Preview {
    let httpService: HTTPClientProtocol = HTTPClient()
    let repository: AppleReposRepositoryProtocol = AppleReposRepository(httpService: httpService as! HTTPClient)
    let useCase: FetchAppleReposUseCase = FetchAppleReposUseCase(repository: repository as! AppleReposRepository)
    
    let viewModel: AppleReposViewModel = AppleReposViewModel(useCase: useCase)
    
    return AppleReposViewController(viewModel: viewModel)
}

