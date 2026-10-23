import Foundation
import UIKit
import SwiftUI

final class EmojisViewController: UIViewController {
    let viewModel: FetchEmojisViewModel
    
    private var emojis: [Emoji] = []
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let getEmojiButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Emoji", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    let errorMessageLabel: UILabel = {
        let errorMessageLabel = UILabel()
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.isHidden = true
        
        return errorMessageLabel
    }()
    
    init(viewModel: FetchEmojisViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EmojiCell")
        
        view.backgroundColor = .systemBackground
        view.addSubview(getEmojiButton)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            getEmojiButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            getEmojiButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getEmojiButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            getEmojiButton.heightAnchor.constraint(equalToConstant: 50),
            
            errorMessageLabel.topAnchor.constraint(equalTo: getEmojiButton.bottomAnchor, constant: 20),
            errorMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            
            tableView.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            
        ])
        
    }
    
    func setupBindings() {
        getEmojiButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            Task {
                await self.viewModel.getEmojis()
            }
        }, for: .touchUpInside)
        
        viewModel.OnStateChange = {[weak self] state in
            guard let self = self else { return }
        
            switch state {
            case .loading:
                self.activityIndicator.startAnimating()
            case .success(let viewModelEmojis):
                self.activityIndicator.stopAnimating()
                self.emojis = viewModelEmojis
                self.tableView.reloadData()
            case .failure(let errorMessage):
                self.activityIndicator.stopAnimating()
                self.errorMessageLabel.text = errorMessage
                

            }
            
        }
    }
    


}

extension EmojisViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)
        
        let item = emojis[indexPath.row]
        
        var emojiName = cell.defaultContentConfiguration()
        emojiName.text = item.name
        
        cell.contentConfiguration = emojiName
        
        return cell
    }
    
    
}

#Preview {
    let repository = EmojiRepository()
    let useCase = FetchEmojisUseCase(repository: repository)
    let viewModel = FetchEmojisViewModel(useCase: useCase)
    return UINavigationController(rootViewController: EmojisViewController(viewModel: viewModel))
}

