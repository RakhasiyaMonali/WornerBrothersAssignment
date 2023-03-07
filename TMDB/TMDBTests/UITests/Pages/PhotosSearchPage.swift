//
//  PhotosSearchPage.swift
// PhotoSearchTests
//
//  Created  by Monali Rakhasiya  on 10/05/2020.
//  Copyright © 2020 Maksym Shcheglov. All rights reserved.
//

import XCTest
import EarlGrey

class PhotosSearchPage: Page {
    
    override func verify() {
        assertExists(AccessibilityIdentifiers.PhotosSearch.rootViewId)
    }
}

// MARK: Actions
extension PhotosSearchPage {
    
    @discardableResult
    func search(_ query: String) -> Self {
        EarlGrey
            .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.PhotosSearch.searchTextFieldId))
            .perform(grey_typeText(query))
        return dismissKeyboard()
    }
    
    @discardableResult
    func tapCell(at index: Int) -> Self {
        return performTap(withId: "\(AccessibilityIdentifiers.PhotosSearch.cellId).\(index)")
    }
}

// MARK: Assertions
extension PhotosSearchPage {
    
    @discardableResult
    func assertScreenTitle(_ text: String) -> Self {
        EarlGrey.selectElement(with: grey_text(text)).assert(grey_sufficientlyVisible())
        return self
    }
    
    @discardableResult
    func assertContentIsHidden() -> Self {
        return assertHidden(AccessibilityIdentifiers.PhotosSearch.tableViewId)
    }
    
    @discardableResult
    func assertPhotosCount(_ rowsCount: Int) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.PhotosSearch.tableViewId))
            .assert(createTableViewRowsAssert(rowsCount: rowsCount, inSection: 0))
        return self
    }

    private func createTableViewRowsAssert(rowsCount: Int, inSection section: Int) -> GREYAssertion {
        return GREYAssertionBlock(name: "TableViewRowsAssert") { (element, error) -> Bool in
            guard let tableView = element as? UITableView, tableView.numberOfSections > section else {
                return false
            }
            let numberOfCells = tableView.numberOfRows(inSection: section)
            return numberOfCells == rowsCount
        }
    }
}
