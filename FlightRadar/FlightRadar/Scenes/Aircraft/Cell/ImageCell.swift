//
//  ImageCell.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/8/21.
//

import UIKit
import RxNuke
import RxSwift
import Nuke
class ImageCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    private var disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerCurve = .continuous
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = UIColor.charcoal.cgColor
        layer.borderWidth = Constants.borderWidth
        layer.masksToBounds = true
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.charcoal.cgColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        disposeBag = DisposeBag()
    }
    
    func configure(with url: URL) {
        ImagePipeline.shared.rx.loadImage(with: url)
            .subscribe(onSuccess: {[weak self] in self?.imageView.image = $0.image})
            .disposed(by: disposeBag)
    }
    
    private enum Constants {
        static let cornerRadius: CGFloat = 18
        static let borderWidth: CGFloat = 2
    }
}
