//
//  FlowCoordinatorDependencyProviders.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit

/// The `ApplicationFlowCoordinatorDependencyProvider` protocol defines methods to satisfy external dependencies of the ApplicationFlowCoordinator
protocol ApplicationFlowCoordinatorDependencyProvider: PhotosSearchFlowCoordinatorDependencyProvider {}

protocol PhotosSearchFlowCoordinatorDependencyProvider: class {
    /// Creates UIViewController to search for a movie
    func photosSearchNavigationController(navigator: PhotosSearchNavigator) -> UINavigationController

    // Creates UIViewController to show the details of the movie with specified identifier
    func photoDetailsController(_ movie: PhotoViewModel) -> UIViewController
}
