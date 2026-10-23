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
            emojiListButton.heightAnchor.constraint(equalToConstant: 50)
        
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
        }
    }
    
    
}

#Preview {
    let repository = EmojiRepository()
    let useCase = GetRandomEmojiUseCase(repository: repository)
    let viewModel = HomeViewModel(useCase: useCase)
    return HomeViewController(viewModel: viewModel)
}
