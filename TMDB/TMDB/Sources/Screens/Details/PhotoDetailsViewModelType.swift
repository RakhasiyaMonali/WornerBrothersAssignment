//
//  PhotoDetailsViewModelType.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit
import Combine

// INPUT
struct PhotoDetailsViewModelInput {
    /// called when a screen becomes visible
    let appear: AnyPublisher<Void, Never>
}

// OUTPUT
enum PhotoDetailsState {
    case loading
    case success(PhotoViewModel)
    case failure(Error)
}

extension PhotoDetailsState: Equatable {
    static func == (lhs: PhotoDetailsState, rhs: PhotoDetailsState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success(let lhsPhoto), .success(let rhsPhoto)): return lhsPhoto == rhsPhoto
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias PhotoDetailsViewModelOutput = AnyPublisher<PhotoDetailsState, Never>

protocol PhotoDetailsViewModelType: AnyObject {
    //func transform(input: PhotoDetailsViewModelInput) -> PhotoDetailsViewModelOutput
}
