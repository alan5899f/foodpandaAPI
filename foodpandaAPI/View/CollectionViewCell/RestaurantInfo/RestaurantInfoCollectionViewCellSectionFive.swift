//
//  RestaurantInfoCollectionViewCellSectionFive.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/17.
//

import UIKit
import Nuke

class RestaurantInfoCollectionViewCellSectionFive: UICollectionViewCell {
    
    static let identifier = "RestaurantInfoCollectionViewCellSectionFive"
    
    private let foodName = UILabel().normal(text: "", ofSize: 18, weight: .bold, textColor: .white)
    private let foodPrice = UILabel().normal(text: "", ofSize: 14, weight: .bold, textColor: .black)
    private let foodImage = UIImageView().customModel(contentMode: .scaleAspectFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        foodName.numberOfLines = 0
        foodImage.layer.cornerRadius = 10
        foodImage.backgroundColor = .systemGray6
        foodPrice.layer.cornerRadius = 15
        foodPrice.layer.masksToBounds = true
        foodPrice.backgroundColor = .white
        foodPrice.textAlignment = .center
        
        contentView.addSubview(foodImage)
        contentView.addSubview(foodPrice)
        contentView.addSubview(foodName)
        
        foodImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, topPadding: 8, bottomPadding: 8, leftPadding: 8, rightPadding: 8)
        foodName.anchor(top: foodImage.topAnchor, left: foodImage.leftAnchor, right: foodImage.rightAnchor, topPadding: 10, leftPadding: 10, rightPadding: 10)
        foodPrice.anchor(bottom: foodImage.bottomAnchor, right: foodImage.rightAnchor, width: 50, height: 30, bottomPadding: 10, rightPadding: 10)
    }
    
    func configure(foodNameString: String, foodImageUrl: String, foodPriceDouble: Double) {
        if foodImageUrl == "" {
            self.foodName.textColor = .black
        }
        else {
            self.foodName.textColor = .white
        }
        foodName.text = foodNameString
        foodPrice.text = "$ \(Int(foodPriceDouble))"
        guard !foodImageUrl.isEmpty else {
            foodImage.image = UIImage(named: "預設背景")
            return
        }
        Nuke.loadImage(with: foodImageUrl, into: foodImage)
    }
    
    required init(coder: NSCoder?) {
        fatalError()
    }
}
