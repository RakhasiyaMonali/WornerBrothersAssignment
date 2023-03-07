//
//  PhotoDetailsViewModel.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit
import Combine

class PhotoDetailsViewModel: PhotoDetailsViewModelType {

    private let photo: PhotoViewModel
    private let useCase: PhotosUseCaseType


    init(photo: PhotoViewModel, useCase: PhotosUseCaseType) {
        self.photo = photo
        self.useCase = useCase
    }

     func viewModel(from photo: PhotoViewModel) -> PhotoViewModel {
        return photo
    }
}
