import Foundation
import UIKit

final class EmojiGridCell: UICollectionViewCell {
    static let reuseIdentifier = "EmojiGridCell"
    
    private var imageTask: Task<Void, Never>?
    
    private let emojiImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil
        emojiImageView.image = nil
    }
    
    func configure(with url: URL) {
        imageTask = Task { @MainActor in
            let image = await ImageLoader.shared.loadImage(from: url)
            
            if !Task.isCancelled {
                emojiImageView.image = image
            }
        }
        
    }
    
    func setupUI() {
        contentView.addSubview(emojiImageView)
        NSLayoutConstraint.activate([
            emojiImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            emojiImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emojiImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emojiImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
