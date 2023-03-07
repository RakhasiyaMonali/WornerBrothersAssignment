//
// PhotoSearchTests.swift
// PhotoSearchTests
//
//  Created  by Monali Rakhasiya  on 08/05/2020.
//  Copyright © 2020 Maksym Shcheglov. All rights reserved.
//

import XCTest
import EarlGrey
import Combine
@testable import PhotoSearch

class PhotosSearchTests: TMDBTestCase {
    
    let PhotosSearchNavigator = PhotosSearchNavigatorMock()
    
    func test_intialState() {
        // GIVEN /WHEN
        open(viewController: factory.photosSearchNavigationController(navigator: PhotosSearchNavigator))

        
        // THEN
        Page.on(PhotosSearchPage.self)
            .assertScreenTitle("Movies")
            .assertContentIsHidden()
            .on(AlertPage.self)
            .assertTitle("Search for a movie...")
    }
    
    func test_startMoviesSearch_whenTypeSearchText() {
        // GIVEN
        let movies = Photos.loadFromFile("Results.json")
        networkService.responses["/3/search/movie"] = movies
        open(viewController: factory.photosSearchNavigationController(navigator: PhotosSearchNavigator))
        
        // WHEN
        Page.on(PhotosSearchPage.self).search("jok")
        
        // THEN
        Page.on(PhotosSearchPage.self).assertPhotosCount(movies.photo.count)
    }
    
    func test_showError_whenNoResultsFound() {
        // GIVEN
        networkService.responses["/3/search/movie"] = Photos.init(photo: [])
        open(viewController: factory.photosSearchNavigationController(navigator: PhotosSearchNavigator))
        
        // WHEN
        Page.on(PhotosSearchPage.self).search("jok")
        
        // THEN
        Page.on(PhotosSearchPage.self)
            .assertContentIsHidden()
            .on(AlertPage.self)
            .assertTitle("No movies found!")
            .assertDescription("Try searching again...")
    }
    
    func test_showError_whenDataLoadingFailed() {
        // GIVEN
        open(viewController: factory.photosSearchNavigationController(navigator: PhotosSearchNavigator))
        
        // WHEN
        Page.on(PhotosSearchPage.self).search("jok")
        
        // THEN
        Page.on(PhotosSearchPage.self)
            .assertContentIsHidden()
            .on(AlertPage.self)
            .assertTitle("Can't load search results!")
            .assertDescription("Something went wrong. Try searching again...")
    }
    
    func test_showDetails_whenTapOnItem() {
        // GIVEN
        let movies = Photos.loadFromFile("Results.json")
        networkService.responses["/3/search/movie"] = movies
        open(viewController: factory.photosSearchNavigationController(navigator: PhotosSearchNavigator))
        
        // WHEN
        Page.on(PhotosSearchPage.self)
            .search("jok")
            .tapCell(at: 0)
        
        // THEN
        XCTAssertTrue(PhotosSearchNavigator.showDetailsForPhotoCalled)
    }

}
