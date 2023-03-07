//
//  PhotosSearchNavigator.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import Foundation

protocol PhotosSearchNavigator: AutoMockable, AnyObject {
    /// Presents the movies details screen
    func showDetails(forPhoto photo: PhotoViewModel)
}
