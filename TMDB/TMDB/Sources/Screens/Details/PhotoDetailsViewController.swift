//
//  PhotoDetailsViewController.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit
import Combine

class PhotoDetailsViewController: UIViewController {
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var poster: UIImageView!

    private let viewModel: PhotoViewModel
    private var cancellables: [AnyCancellable] = []
    private let appear = PassthroughSubject<Void, Never>()

    init(viewModel: PhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = AccessibilityIdentifiers.PhotoDetails.rootViewId
        contentView.accessibilityIdentifier = AccessibilityIdentifiers.PhotoDetails.contentViewId
        loadingIndicator.accessibilityIdentifier = AccessibilityIdentifiers.PhotoDetails.loadingIndicatorId
        show(self.viewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appear.send(())
    }

    private func show(_ photoDetails: PhotoViewModel) {
        photoDetails.photoUrl
            .assign(to: \UIImageView.image, on: self.poster)
            .store(in: &cancellables)
    }
}
