//
//  PhotosSearchViewModel.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit
import Combine

final class PhotosSearchViewModel: PhotosSearchViewModelType {

    private weak var navigator: PhotosSearchNavigator?
    private let useCase: PhotosUseCaseType
    private var cancellables: [AnyCancellable] = []

    init(useCase: PhotosUseCaseType, navigator: PhotosSearchNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: PhotosSearchViewModelInput) -> PhotosSearchViewModelOuput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        input.selection
            .sink(receiveValue: { [unowned self] photo in self.navigator?.showDetails(forPhoto: photo) })
            .store(in: &cancellables)

        let searchInput = input.search
            .debounce(for: .milliseconds(300), scheduler: Scheduler.mainScheduler)
            .removeDuplicates()
        let photos = searchInput
            .filter({ !$0.isEmpty })
            .flatMapLatest({[unowned self] query in self.useCase.searchPhotos(with: query) })
            .map({ result -> PhotosSearchState in
                switch result {
                case .success(let photos) where photos.items.photo.isEmpty: return .noResults
                case .success(let photos): return .success(self.viewModels(from: photos.items.photo))
                case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()

        let initialState: PhotosSearchViewModelOuput = .just(.idle)
        let emptySearchString: PhotosSearchViewModelOuput = searchInput.filter({ $0.isEmpty }).map({ _ in .idle }).eraseToAnyPublisher()
        let idle: PhotosSearchViewModelOuput = Publishers.Merge(initialState, emptySearchString).eraseToAnyPublisher()

        return Publishers.Merge(idle, photos).removeDuplicates().eraseToAnyPublisher()
    }

    private func viewModels(from photos: [Photo]) -> [PhotoViewModel] {
        return photos.map({[unowned self] photo in
            return PhotoViewModelBuilder.viewModel(from: photo, imageLoader: {[unowned self] photo in self.useCase.loadImage(for: photo) })
        })
    }

}
