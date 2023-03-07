//
//  PhotoViewModelBuilder.swift
// PhotoSearch
//
//  Created  by Monali Rakhasiya  on 05/03/2023.
//

import Foundation
import UIKit.UIImage
import Combine

struct PhotoViewModelBuilder {
    static func viewModel(from photo: Photo, imageLoader: (Photo) -> AnyPublisher<UIImage?, Never>) -> PhotoViewModel {
        return PhotoViewModel(id: photo.id,
                              owner: photo.owner,
                              secret: photo.secret,
                              server: photo.server,
                              farm: photo.farm,
                              title: photo.title,
                              photoUrl: imageLoader(photo))
    }
}
