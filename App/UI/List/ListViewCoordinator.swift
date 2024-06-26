//
//  ListViewCoordinator.swift
//  App
//
//

import UIKit

class ListViewCoordinator {

    weak var navigationController: UINavigationController?
    private weak var viewController: ListViewController?

    public func start(window: UIWindow) {
        let viewModel = ListViewModel()

        viewModel.showDetail = { forecastItem in
            let detailViewController = DetailViewController(forecastItem: forecastItem)
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }

        let viewController = ListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController

        self.navigationController = navigationController
        self.viewController = viewController
    }
}
