//
//  FlowCoordinator.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit

/// A `FlowCoordinator` takes responsibility about coordinating view controllers and driving the flow in the application.
protocol FlowCoordinator: AnyObject {

    /// Stars the flow
    func start()
}

