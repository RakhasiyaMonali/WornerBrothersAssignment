//
// PhotoSearch
//
//  Created  by Monali Rakhasiya .
//  Copyright © 2021 Maksym Shcheglov. All rights reserved.
//

import Foundation
import XCTest
import Combine
@testable import PhotoSearch

class PhotosSearchViewModelTests: XCTestCase {
    private let useCase = PhotosUseCaseTypeMock()
    private let navigator = PhotosSearchNavigatorMock()
    private var viewModel: PhotosSearchViewModel!
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        viewModel = PhotosSearchViewModel(useCase: useCase, navigator: navigator)
    }

    func test_loadData_onSearch() {
        // Given
        let search = PassthroughSubject<String, Never>()
        let input = PhotosSearchViewModelInput(appear: .just(()), search: search.eraseToAnyPublisher(), selection: .empty())
        var state: PhotosSearchState?

        let expectation = self.expectation(description: "photos")
        let photos = Results.loadFromFile("Results.json")
        let expectedViewModels = photos.items.photo.map({ photo in
            return PhotoViewModelBuilder.viewModel(from: photo, imageLoader: { _ in .just(UIImage()) })
        })
        useCase.searchPhotosWithReturnValue = .just(.success(photos))
        useCase.loadImageForSizeReturnValue = .just(UIImage())
        viewModel.transform(input: input).sink { value in
            guard case PhotosSearchState.success = value else { return }
            state = value
            expectation.fulfill()
        }.store(in: &cancellables)

        // When
        search.send("joker")

        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(state!, .success(expectedViewModels))
    }

    func test_hasErrorState_whenDataLoadingIsFailed() {
        // Given
        let search = PassthroughSubject<String, Never>()
        let input = PhotosSearchViewModelInput(appear: .just(()), search: search.eraseToAnyPublisher(), selection: .empty())
        var state: PhotosSearchState?

        let expectation = self.expectation(description: "photos")
        useCase.searchPhotosWithReturnValue = .just(.failure(NetworkError.invalidResponse))
        useCase.loadImageForSizeReturnValue = .just(UIImage())
        viewModel.transform(input: input).sink { value in
            guard case .failure = value else { return }
            state = value
            expectation.fulfill()
        }.store(in: &cancellables)

        // When
        search.send("joker")

        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(state!, .failure(NetworkError.invalidResponse))
    }

}
