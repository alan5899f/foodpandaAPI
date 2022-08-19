//
//  HomeCollectionViewCellSectionFour.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/6.
//

import UIKit
import Nuke

class HomeCollectionViewCellSectionFour: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCellSectionFour"
    
    private let discountImageView = UIImageView().customModel(contentMode: .scaleToFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        discountImageView.layer.cornerRadius = 10
        discountImageView.backgroundColor = .systemGray6
        contentView.addSubview(discountImageView)
        discountImageView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, bottomPadding: 20, leftPadding: 15)
    }
    
    func configure(imageUrl: String) {
        Nuke.loadImage(with: imageUrl, into: discountImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
