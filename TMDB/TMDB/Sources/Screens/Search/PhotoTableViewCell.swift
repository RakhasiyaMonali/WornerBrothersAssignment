//
//  PhotoTableViewCell.swift
// PhotoSearch
//
//  Created  by Monali Rakhasiya  on 05/03/2023.
//

import UIKit
import Combine

class PhotoTableViewCell: UITableViewCell, NibProvidable, ReusableView {

    @IBOutlet private var title: UILabel!
    @IBOutlet private var poster: UIImageView!
    private var cancellable: AnyCancellable?

    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
    }

    func bind(to viewModel: PhotoViewModel) {
        cancelImageLoading()
        title.text = viewModel.title
        cancellable = viewModel.photoUrl.sink { [unowned self] image in self.showImage(image: image) }
    }

    private func showImage(image: UIImage?) {
        cancelImageLoading()
        UIView.transition(with: self.poster,
        duration: 0.3,
        options: [.curveEaseOut, .transitionCrossDissolve],
        animations: {
            self.poster.image = image
        })
    }

    private func cancelImageLoading() {
        poster.image = nil
        cancellable?.cancel()
    }

}
