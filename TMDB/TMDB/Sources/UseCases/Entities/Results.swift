//
//  Movies.swift
// PhotoSearch
//
//  Created  by Monali Rakhasiya  on 05/03/2023.
//

import Foundation

struct Results {
    let items: Photos
}

extension Results: Decodable {

    enum CodingKeys: String, CodingKey {
        case items = "photos"
    }
}

struct Photos {
    let photo: [Photo]
}

extension Photos: Decodable {

    enum CodingKeys: String, CodingKey {
        case photo = "photo"
    }
}
