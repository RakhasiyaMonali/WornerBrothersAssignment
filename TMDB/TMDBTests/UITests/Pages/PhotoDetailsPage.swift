//
//  PhotoDetailsPage.swift
// PhotoSearchTests
//
//  Created  by Monali Rakhasiya  on 10/05/2020.
//  Copyright © 2020 Maksym Shcheglov. All rights reserved.
//

import XCTest
import EarlGrey

class PhotoDetailsPage: Page {
    
    override func verify() {
        assertVisible(AccessibilityIdentifiers.PhotoDetails.rootViewId)
    }
}

// MARK: Assertions
extension PhotoDetailsPage {
    
    @discardableResult
    func assertContentIsHidden() -> Self {
        return assertHidden(AccessibilityIdentifiers.PhotoDetails.contentViewId)
    }
    
    @discardableResult
    func assertLoadingIndicatorIsVisible() -> Self {
        return assertVisible(AccessibilityIdentifiers.PhotoDetails.loadingIndicatorId)
    }
    
    @discardableResult
    func assertLoadingIndicatorIsHidden() -> Self {
        return assertHidden(AccessibilityIdentifiers.PhotoDetails.loadingIndicatorId)
    }

}

