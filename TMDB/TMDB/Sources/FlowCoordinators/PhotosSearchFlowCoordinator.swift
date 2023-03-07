//
//  MoviesSearchFlowCoordinator.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit

/// The `MoviesSearchFlowCoordinator` takes control over the flows on the movies search screen
class PhotosSearchFlowCoordinator: FlowCoordinator {
    fileprivate let window: UIWindow
    fileprivate var searchNavigationController: UINavigationController?
    fileprivate let dependencyProvider: PhotosSearchFlowCoordinatorDependencyProvider

    init(window: UIWindow, dependencyProvider: PhotosSearchFlowCoordinatorDependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }

    func start() {
        let searchNavigationController = dependencyProvider.photosSearchNavigationController(navigator: self)
        window.rootViewController = searchNavigationController
        self.searchNavigationController = searchNavigationController
    }
}

extension PhotosSearchFlowCoordinator: PhotosSearchNavigator {

    func showDetails(forPhoto photo: PhotoViewModel) {
        let controller = self.dependencyProvider.photoDetailsController(photo)
        searchNavigationController?.pushViewController(controller, animated: true)
    }

}
