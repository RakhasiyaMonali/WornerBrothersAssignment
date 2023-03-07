//
//  Resource+Movie.swift
// PhotoSearch
//
//  Created  by Monali Rakhasiya  on 05/03/2023.
//

import Foundation

extension Resource {

    static func photos(query: String) -> Resource<Results> {
        let url = ApiConstants.baseUrl.appendingPathComponent("services/rest")
        let parameters: [String : CustomStringConvertible] = [
            "method": "flickr.photos.search",
            "api_key": ApiConstants.apiKey,
            "tags": query,
            "format": "json",
            "nojsoncallback": "1"
            ]
        return Resource<Results>(url: url, parameters: parameters)
    }
}

