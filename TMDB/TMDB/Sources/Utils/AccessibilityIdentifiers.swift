//
//  AccessibilityIdentifiers.swift
// PhotoSearch
//
//  Created  by Monali Rakhasiya  on 09/05/2020.
//  Copyright © 2020 Maksym Shcheglov. All rights reserved.
//

import Foundation

public struct AccessibilityIdentifiers {
    
    public struct PhotosSearch {
        public static let rootViewId = "\(PhotosSearch.self).rootViewId"
        public static let tableViewId = "\(PhotosSearch.self).tableViewId"
        public static let searchTextFieldId = "\(PhotosSearch.self).searchTextFieldId"
        public static let cellId = "\(PhotosSearch.self).cellId"
    }
    
    public struct PhotoDetails {
        public static let rootViewId = "\(PhotoDetails.self).rootViewId"
        public static let contentViewId = "\(PhotoDetails.self).contentViewId"
        public static let loadingIndicatorId = "\(PhotoDetails.self).loadingIndicatorId"
    }
    
    public struct Alert {
        public static let rootViewId = "\(Alert.self).rootViewId"
        public static let titleLabelId = "\(Alert.self).titleLabelId"
        public static let descriptionLabelId = "\(Alert.self).descriptionLabelId"
    }
}
