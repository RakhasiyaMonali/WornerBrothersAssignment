//
// PhotoSearch
//
//  Created  by Monali Rakhasiya .
//  Copyright © 2021 Maksym Shcheglov. All rights reserved.
//

import Foundation
import XCTest
@testable import PhotoSearch

class ApplicationFlowCoordinatorTests: XCTestCase {

    private lazy var flowCoordinator = ApplicationFlowCoordinator(window: window, dependencyProvider: dependencyProvider)
    private let window =  UIWindow()
    private let dependencyProvider = ApplicationFlowCoordinatorDependencyProviderMock()

    /// Test that application flow is started correctly
    func test_startsApplicationsFlow() {
        // GIVEN
        let rootViewController = UINavigationController()
        dependencyProvider.photosSearchNavigationControllerReturnValue = rootViewController

        // WHEN
        flowCoordinator.start()

        // THEN
        XCTAssertEqual(window.rootViewController, rootViewController)
    }
}
