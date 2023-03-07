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

class PhotosUseCaseTests: XCTestCase {

    private let networkService = NetworkServiceTypeMock()
    private let imageLoaderService = ImageLoaderServiceTypeMock()
    private var useCase: PhotosUseCase!
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        useCase = PhotosUseCase(networkService: networkService,
                                imageLoaderService: imageLoaderService)
    }

    func test_searchPhotosSucceeds() {
        // Given
        var result: Result<Results, Error>!
        let expectation = self.expectation(description: "photos")
        let photos = Photos.loadFromFile("Results.json")
        networkService.responses["/3/search/movie"] = photos

        // When
        useCase.searchPhotos(with: "joker").sink { value in
            result = value
            expectation.fulfill()
        }.store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .success = result! else {
            XCTFail()
            return
        }
    }

    func test_searchPhotosFailes_onNetworkError() {
        // Given
        var result: Result<Results, Error>!
        let expectation = self.expectation(description: "photos")
        networkService.responses["/3/search/movie"] = NetworkError.invalidResponse

        // When
        useCase.searchPhotos(with: "joker").sink { value in
            result = value
            expectation.fulfill()
        }.store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .failure = result! else {
            XCTFail()
            return
        }
    }

    func test_loadsImageFromNetwork() {
        // Given
        let photos = Photos.loadFromFile("Results.json")
        let photo = photos.photo.first!
        var result: UIImage?
        let expectation = self.expectation(description: "loadImage")
        imageLoaderService.loadImageFromReturnValue = .just(UIImage())

        // When
        useCase.loadImage(for: photo).sink { value in
            result = value
            expectation.fulfill()
        }.store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(result)
    }
}
