//
//  HomeCollectionViewCellSectionThree.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/6.
//

import UIKit
import Nuke

class HomeCollectionViewCellSectionThree: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCellSectionThree"
    
    private let foodImageView = UIImageView().customModel(contentMode: .scaleAspectFill)
    private let foodTitle = UILabel().normal(text: "", ofSize: 14, weight: .medium, textColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        foodTitle.textAlignment = .center
        foodTitle.text = "台式"
        foodImageView.backgroundColor = .systemGray6
        foodImageView.layer.cornerRadius = 10
        
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodTitle)
        
        foodImageView.anchor(top: contentView.topAnchor, bottom: foodTitle.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, height: contentView.width - 10, leftPadding: 10)
        foodTitle.anchor(top: foodImageView.bottomAnchor, centerX: contentView.centerXAnchor, topPadding: 10)
    }
    
    func configure(title: String, imageUrl: String) {
        foodTitle.text = title
        Nuke.loadImage(with: imageUrl, into: foodImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
