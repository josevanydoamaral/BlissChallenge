import Foundation
import UIKit

@MainActor
final class AppCoordinator {
    let navigationController: UINavigationController
    let container: AppContainer
    
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let viewModel = container.makeHomeViewModel()
        let homeViewController = HomeViewController(viewModel: viewModel)
        homeViewController.onShowEmoji = { [weak self] in self?.showEmojis() }
        
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func showEmojis() {
        let viewModel = container.makeFetchEmojisViewModel()
        let emojisViewController = EmojisViewController(viewModel: viewModel)
        
        navigationController.pushViewController(emojisViewController, animated: true)
    }
}
