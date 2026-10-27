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
        homeViewController.onShowUsers = { [weak self] in self?.showUsers() }
        homeViewController.onShowAppleRepos = { [weak self] in self?.showAppleRepos() }
        
        
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func showEmojis() {
        let viewModel = container.makeFetchEmojisViewModel()
        let emojisViewController = EmojisViewController(viewModel: viewModel)
        
        navigationController.pushViewController(emojisViewController, animated: true)
    }
    
    func showUsers() {
        let viewModel = container.makeUsersViewModel()
        let usersViewController = UsersViewController(viewModel: viewModel)
        
        navigationController.pushViewController(usersViewController, animated: true)

    }
    
    func showAppleRepos() {
        let viewModel = container.makeAppleReposViewModel()
        
        let appleReposVC = AppleReposViewController(viewModel: viewModel)
        
        navigationController.pushViewController(appleReposVC, animated: true)

    }
}
