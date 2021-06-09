//
//  GenericCoordinator.swift
//  test-auto-coordinator
//
//  Created by Albert Montserrat on 9/6/21.
//

import UIKit

class GenericCoordinator {

    enum PresentationStyle {
        case push(navigationController: UINavigationController)
        case present(presenter: UIViewController)
    }

    let presentationStyle: PresentationStyle
    weak var navigationViewController: UINavigationController?
    var counter = 1

    init(presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
        logging?("Init coordinator", .green)
    }

    func start() {
        switch presentationStyle {
        case let .push(navigationController):
            self.navigationViewController = navigationController
            navigationController.pushViewController(initializeScreen(), animated: true)
        case let .present(presenter):
            let navigationController = UINavigationController(rootViewController: initializeScreen())
            self.navigationViewController = navigationController
            presenter.present(navigationController, animated: true, completion: nil)
        }
    }

    private func initializeScreen() -> UIViewController {
        let viewModel = ViewModel(delegate: self, counter: counter)
        return ViewController(viewModel: viewModel)
    }

    private func incrementCounter() {
        counter += 1
    }

    deinit {
        logging?("Deninit Coordinator", .red)
    }
}

extension GenericCoordinator: ViewModelDelegate {
    func didSelectPush() {
        incrementCounter()
        navigationViewController?.pushViewController(initializeScreen(), animated: true)
    }

    func didSelectPushNewFlow() {
        guard let navigationViewController = navigationViewController else { return }
        GenericCoordinator(
            presentationStyle: .push(
                navigationController: navigationViewController
            )
        ).start()
    }

    func didSelectPresent() {
        guard let navigationViewController = navigationViewController else { return }
        GenericCoordinator(
            presentationStyle: .present(
                presenter: navigationViewController
            )
        ).start()
    }
}
