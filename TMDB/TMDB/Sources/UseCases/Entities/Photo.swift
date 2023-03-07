//
//  Photos.swift
// PhotoSearch
//
//  Created by Monali on 05/03/23.
//  Copyright © 2023 Maksym Shcheglov. All rights reserved.
//

import Foundation
struct Photo {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    
    var photoUrl: String? {
        return ApiConstants.originalImageUrl + server + "/" + id + "_" + secret + "_w.png"
    }
//    var fullPhotoUrl: String? {
//        return ApiConstants.originalImageUrl + server + "/" + id + "_" + secret + "_b.png"
//    }
}

extension Photo: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case secret
        case server
        case farm
        case title
    }
}
