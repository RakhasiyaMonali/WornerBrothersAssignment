//
//  PhotoViewModel.swift
// PhotoSearch
//
//  Created  by Monali Rakhasiya  on 05/03/2023.
//

import Foundation
import UIKit.UIImage
import Combine

struct PhotoViewModel: Equatable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let photoUrl: AnyPublisher<UIImage?, Never>

    init(id: String, owner: String, secret: String, server: String, farm: Int, title: String, photoUrl: AnyPublisher<UIImage?, Never>) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.photoUrl = photoUrl
    }
}

extension PhotoViewModel: Hashable {
    static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
//
