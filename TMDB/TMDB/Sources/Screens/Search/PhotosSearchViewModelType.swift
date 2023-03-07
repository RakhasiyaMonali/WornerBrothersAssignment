//
//  PhotosSearchViewModelType.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import Combine

struct PhotosSearchViewModelInput {
    /// called when a screen becomes visible
    let appear: AnyPublisher<Void, Never>
    // triggered when the search query is updated
    let search: AnyPublisher<String, Never>
    /// called when the user selected an item from the list
    let selection: AnyPublisher<PhotoViewModel, Never>
}

enum PhotosSearchState {
    case idle
    case loading
    case success([PhotoViewModel])
    case noResults
    case failure(Error)
}

extension PhotosSearchState: Equatable {
    static func == (lhs: PhotosSearchState, rhs: PhotosSearchState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.success(let lhsMovies), .success(let rhsMovies)): return lhsMovies == rhsMovies
        case (.noResults, .noResults): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias PhotosSearchViewModelOuput = AnyPublisher<PhotosSearchState, Never>

protocol PhotosSearchViewModelType {
    func transform(input: PhotosSearchViewModelInput) -> PhotosSearchViewModelOuput
}
