//
//  ImageLoaderServiceType.swift
// PhotoSearch
//
//  Created  by Monali Rakhasiya  on 05/03/2023.
//

import Foundation
import UIKit.UIImage
import Combine

protocol ImageLoaderServiceType: AnyObject, AutoMockable {
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}
