//
//  ApplicationFlowCoordinator.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit

/// The application flow coordinator. Takes responsibility about coordinating view controllers and driving the flow
class ApplicationFlowCoordinator: FlowCoordinator {

    typealias DependencyProvider = ApplicationFlowCoordinatorDependencyProvider

    private let window: UIWindow
    private let dependencyProvider: DependencyProvider
    private var childCoordinators = [FlowCoordinator]()

    init(window: UIWindow, dependencyProvider: DependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }

    /// Creates all necessary dependencies and starts the flow
    func start() {
        let searchFlowCoordinator = PhotosSearchFlowCoordinator(window: window, dependencyProvider: self.dependencyProvider)
        childCoordinators = [searchFlowCoordinator]
        searchFlowCoordinator.start()
    }

}
