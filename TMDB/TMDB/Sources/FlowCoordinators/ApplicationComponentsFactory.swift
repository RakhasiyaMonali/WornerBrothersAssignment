//
//  ApplicationComponentsFactory.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit

/// The ApplicationComponentsFactory takes responsibity of creating application components and establishing dependencies between them.
final class ApplicationComponentsFactory {
    fileprivate lazy var useCase: PhotosUseCaseType = PhotosUseCase(networkService: servicesProvider.network, imageLoaderService: servicesProvider.imageLoader)

    private let servicesProvider: ServicesProvider

    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()) {
        self.servicesProvider = servicesProvider
    }
}

extension ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {

    func photosSearchNavigationController(navigator: PhotosSearchNavigator) -> UINavigationController {
        let viewModel = PhotosSearchViewModel(useCase: useCase, navigator: navigator)
        let PhotosSearchViewController = PhotosSearchViewController(viewModel: viewModel)
        let moviesSearchNavigationController = UINavigationController(rootViewController: PhotosSearchViewController)
        moviesSearchNavigationController.navigationBar.tintColor = .label
        return moviesSearchNavigationController
    }

    func photoDetailsController(_ movie: PhotoViewModel) -> UIViewController {
        let viewModel = PhotoDetailsViewModel(photo: movie, useCase: useCase)
        return PhotoDetailsViewController(viewModel: movie)
    }
}
