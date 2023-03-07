// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
import XCTest
import Combine
@testable import PhotoSearch

class ImageLoaderServiceTypeMock: ImageLoaderServiceType {

    //MARK: - loadImage

    var loadImageFromCallsCount = 0
    var loadImageFromCalled: Bool {
        return loadImageFromCallsCount > 0
    }
    var loadImageFromReceivedUrl: URL?
    var loadImageFromReceivedInvocations: [URL] = []
    var loadImageFromReturnValue: AnyPublisher<UIImage?, Never>!
    var loadImageFromClosure: ((URL) -> AnyPublisher<UIImage?, Never>)?

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        loadImageFromCallsCount += 1
        loadImageFromReceivedUrl = url
        loadImageFromReceivedInvocations.append(url)
        return loadImageFromClosure.map({ $0(url) }) ?? loadImageFromReturnValue
    }



}
class PhotosSearchNavigatorMock: PhotosSearchNavigator {
    //MARK: - showDetails

    var showDetailsForPhotoCallsCount = 0
    var showDetailsForPhotoCalled: Bool {
        return showDetailsForPhotoCallsCount > 0
    }
    var showDetailsForPhotoReceivedPhoto: PhotoViewModel?
    var showDetailsForPhotoReceivedInvocations: [PhotoViewModel] = []
    var showDetailsForPhotoClosure: ((PhotoViewModel) -> Void)?

    func showDetails(forPhoto photo: PhotoViewModel) {
        showDetailsForPhotoCallsCount += 1
        showDetailsForPhotoReceivedPhoto = photo
        showDetailsForPhotoReceivedInvocations.append(photo)
        showDetailsForPhotoClosure?(photo)
    }



}
class PhotosUseCaseTypeMock: PhotosUseCaseType {

    //MARK: - searchPhotos

    var searchPhotosWithCallsCount = 0
    var searchPhotosWithCalled: Bool {
        return searchPhotosWithCallsCount > 0
    }
    var searchPhotosWithReceivedName: String?
    var searchPhotosWithReceivedInvocations: [String] = []
    var searchPhotosWithReturnValue: AnyPublisher<Result<Results, Error>, Never>!
    var searchPhotosWithClosure: ((String) -> AnyPublisher<Result<Results, Error>, Never>)?

    func searchPhotos(with name: String) -> AnyPublisher<Result<Results, Error>, Never> {
        searchPhotosWithCallsCount += 1
        searchPhotosWithReceivedName = name
        searchPhotosWithReceivedInvocations.append(name)
        return searchPhotosWithClosure.map({ $0(name) }) ?? searchPhotosWithReturnValue
    }

    //MARK: - loadImage

    var loadImageForSizeCallsCount = 0
    var loadImageForSizeCalled: Bool {
        return loadImageForSizeCallsCount > 0
    }
    var loadImageForSizeReceivedArguments: (Photo)?
    var loadImageForSizeReceivedInvocations: [(Photo)] = []
    var loadImageForSizeReturnValue: AnyPublisher<UIImage?, Never>!
    var loadImageForSizeClosure: ((Photo) -> AnyPublisher<UIImage?, Never>)?

    func loadImage(for photo: Photo) -> AnyPublisher<UIImage?, Never> {
        loadImageForSizeCallsCount += 1
        loadImageForSizeReceivedArguments = (photo)
        loadImageForSizeReceivedInvocations.append((photo))
        return loadImageForSizeClosure.map({ $0(photo) }) ?? loadImageForSizeReturnValue
    }

}

class NetworkServiceTypeMock: NetworkServiceType {

    var loadCallsCount = 0
    var loadCalled: Bool {
        return loadCallsCount > 0
    }
    var responses = [String:Any]()

    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> {
        if let response = responses[resource.url.path] as? T {
            return .just(response)
        } else if let error = responses[resource.url.path] as? NetworkError {
            return .fail(error)
        } else {
            return .fail(NetworkError.invalidRequest)
        }
    }
}

class ApplicationFlowCoordinatorDependencyProviderMock: ApplicationFlowCoordinatorDependencyProvider {

    var photosSearchNavigationControllerReturnValue: UINavigationController?
    func photosSearchNavigationController(navigator: PhotosSearchNavigator) -> UINavigationController {
        return photosSearchNavigationControllerReturnValue!
    }

    var photoDetailsControllerReturnValue: UIViewController?
    func photoDetailsController(_ photo: PhotoViewModel) -> UIViewController {
        return photoDetailsControllerReturnValue!
    }
}
