//
//  FoodDeliveryCollectionViewCellSectionThree.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/8.
//

import UIKit
import Nuke

class FoodDeliveryCollectionViewCellSectionThree: UICollectionViewCell {
    
    static let identifier = "FoodDeliveryCollectionViewCellSectionThree"
    
    private let foodImageView = UIImageView().customModel(contentMode: .scaleAspectFill)
    private let foodTitle = UILabel().normal(text: "", ofSize: 12, weight: .medium, textColor: .black)
    private let gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        foodTitle.textAlignment = .center
        foodTitle.text = "台式"
        foodImageView.backgroundColor = .systemGray6
        foodImageView.layer.cornerRadius = 10
        
        gradient.colors = [UIColor.white.withAlphaComponent(0.5).cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradient.locations = [0.3, 0.7]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.cornerRadius = 10
        
        foodImageView.layer.shadowColor = UIColor.black.cgColor
        foodImageView.layer.shadowRadius = 10
        foodImageView.layer.shadowOpacity = 0.2
        foodImageView.layer.masksToBounds = false
        
        contentView.addSubview(foodImageView)
        contentView.layer.addSublayer(gradient)
        contentView.addSubview(foodTitle)
        
        foodImageView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 5)
        gradient.frame = CGRect(x: 5, y: 5, width: contentView.width - 10, height: contentView.height - 10)
        foodTitle.anchor(bottom: foodImageView.bottomAnchor, left: foodImageView.leftAnchor, bottomPadding: 8, leftPadding: 8)
    }
    
    func configure(title: String, imageUrl: String) {
        foodTitle.text = title
        Nuke.loadImage(with: imageUrl, into: foodImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
