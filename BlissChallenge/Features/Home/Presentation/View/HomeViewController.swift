import Foundation
import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    
}

#Preview {
    let repository = EmojiRepository()
    let useCase = GetRandomEmojiUseCase(repository: repository)
    let viewModel = HomeViewModel(useCase: useCase)
    return HomeViewController(viewModel: viewModel)
}
