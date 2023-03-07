//
//  AlertView.swift
// PhotoSearch
//
//  Created  by Monali Rakhasiya  on 05/03/2023.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = AccessibilityIdentifiers.Alert.rootViewId
        titleLabel.accessibilityIdentifier = AccessibilityIdentifiers.Alert.titleLabelId
        descriptionLabel.accessibilityIdentifier = AccessibilityIdentifiers.Alert.descriptionLabelId
    }

    func showStartSearch() {
        render(viewModel: AlertViewModel.startSearch)
    }

    func showNoResults() {
        render(viewModel: AlertViewModel.noResults)
    }

    func showDataLoadingError() {
        render(viewModel: AlertViewModel.dataLoadingError)
    }

    fileprivate func render(viewModel: AlertViewModel) {
        titleLabel.text = viewModel.title
        imageView.image = viewModel.image
    }
}
