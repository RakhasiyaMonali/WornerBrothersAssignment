//
//  PhotosUseCase.swift
// PhotoSearch
//
//  Created  by Monali Rakhasiya  on 05/03/2023.
//

import Foundation
import Combine
import UIKit.UIImage

protocol PhotosUseCaseType: AutoMockable {

    /// Runs photos search with a query string
    func searchPhotos(with name: String) -> AnyPublisher<Result<Results, Error>, Never>

    // Loads image for the given photo
    func loadImage(for photo: Photo) -> AnyPublisher<UIImage?, Never>
}

final class PhotosUseCase: PhotosUseCaseType {

    private let networkService: NetworkServiceType
    private let imageLoaderService: ImageLoaderServiceType

    init(networkService: NetworkServiceType, imageLoaderService: ImageLoaderServiceType) {
        self.networkService = networkService
        self.imageLoaderService = imageLoaderService
    }

    func searchPhotos(with name: String) -> AnyPublisher<Result<Results, Error>, Never> {
        return networkService
            .load(Resource<Results>.photos(query: name))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<Results, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }

    func loadImage(for photo: Photo) -> AnyPublisher<UIImage?, Never> {
        return Deferred { return Just(photo.photoUrl) }
        .flatMap({[unowned self] poster -> AnyPublisher<UIImage?, Never> in
            guard let poster = photo.photoUrl else { return .just(nil) }
            
            return self.imageLoaderService.loadImage(from: URL(string: poster)!)
        })
        .subscribe(on: Scheduler.backgroundWorkScheduler)
        .receive(on: Scheduler.mainScheduler)
        .share()
        .eraseToAnyPublisher()
    }

}
