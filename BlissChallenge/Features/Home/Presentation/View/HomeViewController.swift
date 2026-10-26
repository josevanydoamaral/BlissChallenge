import Foundation
import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    
    var onShowEmoji: (() -> Void)?
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Tap 'Random Emoji' button to see a random Emoji"
        label.isHidden = true
        
        return label
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.isHidden = true
        
        return label
    }()
    
    let randomEmojiButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Random Emoji", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        
        return button
    }()
    
    let emojiListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Emoji List", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        
        return button
    }()
    
    let searchErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        
        return label
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Digite o nome de utilizador"
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray4
                
        return textField
    }()
    
    let searchbutton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    let avatarListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Avatar List", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        
        return button
    }()
    
    let appleReposListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apple Repos", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        
        return button
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        view.addSubview(errorLabel)
        view.addSubview(randomEmojiButton)
        view.addSubview(emojiListButton)
        view.addSubview(searchTextField)
        view.addSubview(searchbutton)
        view.addSubview(searchErrorLabel)
        view.addSubview(avatarListButton)
        view.addSubview(appleReposListButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            
            errorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            randomEmojiButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20),
            randomEmojiButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            randomEmojiButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            randomEmojiButton.heightAnchor.constraint(equalToConstant: 50),
            
            emojiListButton.topAnchor.constraint(equalTo: randomEmojiButton.bottomAnchor, constant: 20),
            emojiListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emojiListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emojiListButton.heightAnchor.constraint(equalToConstant: 50),
            
            searchTextField.topAnchor.constraint(equalTo: emojiListButton.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            
            searchbutton.topAnchor.constraint(equalTo: emojiListButton.bottomAnchor, constant: 20),
            searchbutton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 10),
            searchbutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchbutton.widthAnchor.constraint(equalToConstant: 90),
                searchbutton.heightAnchor.constraint(equalToConstant: 44),
            
            searchErrorLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            searchErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            avatarListButton.topAnchor.constraint(equalTo: searchErrorLabel.bottomAnchor, constant: 20),
            avatarListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            avatarListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            avatarListButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            appleReposListButton.topAnchor.constraint(equalTo: avatarListButton.bottomAnchor, constant: 20),
            appleReposListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appleReposListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            appleReposListButton.heightAnchor.constraint(equalToConstant: 50),
        
        ])
    }
    
    func setupData() {
        randomEmojiButton.addAction(UIAction{ [weak self] _ in
            guard let self = self else { return }
        
            Task {
                await self.viewModel.getRandomEmoji()
            }
        }, for: .touchUpInside)
        
        emojiListButton.addAction(UIAction {[weak self] _ in
            guard let self = self else { return }
            
            onShowEmoji?()
                    
        }, for: .touchUpInside)
        
        searchbutton.addAction(UIAction {[weak self] _ in
            guard let self = self else { return }
                        
            guard let searchTerm = searchTextField.text?.lowercased() else {
                return
            }
            
            Task {
                
                await self.viewModel.getUser(searhTerm: searchTerm)
            }
        }, for: .touchUpInside)
        
        viewModel.OnStateChange = { [weak self] state in
            guard let self = self else { return }
            
            switch state.emojiState {
                
            case .idle:
                randomEmojiButton.isEnabled = true
                descriptionLabel.isHidden = false
                errorLabel.isHidden = true

            case .loading:
                randomEmojiButton.isEnabled = false
                descriptionLabel.isHidden = true
                errorLabel.isHidden = true

            case .success:
                randomEmojiButton.isEnabled = true
                descriptionLabel.isHidden = true
                errorLabel.isHidden = true
                
                guard let imageData = state.randomEmoji?.imageData else { break }
                
                imageView.image = UIImage(data: imageData)
                
            case .failure(let error):
                randomEmojiButton.isEnabled = true
                descriptionLabel.isHidden = true
                errorLabel.isHidden = false
                errorLabel.text = error
            }
            
            switch state.userState {
            case .idle:
                searchbutton.isEnabled = true
            case .loading:
                searchbutton.isEnabled = false
            case .success:
                searchbutton.isEnabled = true
                searchErrorLabel.isHidden = false
                searchErrorLabel.text = "User found"
                searchErrorLabel.textColor = .systemGreen

            case .failure(let errorMessage):
                searchbutton.isEnabled = true
                searchErrorLabel.isHidden = false
                searchErrorLabel.textColor = .systemRed
                searchErrorLabel.text = errorMessage
            }
        }
    }
    
    
}

#Preview {
    let navigationController = UINavigationController()
    
    let container = AppContainer()
    
    let coordinator = AppCoordinator(navigationController: navigationController, container: container)
    
    coordinator.start()
    
    return navigationController
}
