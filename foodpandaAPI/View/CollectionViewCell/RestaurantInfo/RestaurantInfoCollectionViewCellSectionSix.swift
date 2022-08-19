//
//  RestaurantInfoCollectionViewCellSectionSix.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/18.
//

import UIKit
import Nuke

class RestaurantInfoCollectionViewCellSectionSix: UICollectionViewCell {
    
    static let identifier = "RestaurantInfoCollectionViewCellSectionSix"
    
    private let foodTitle = UILabel().normal(text: "", ofSize: 16, weight: .medium, textColor: .black)
    private let foodDescription = UILabel().normal(text: "", ofSize: 14, weight: .regular, textColor: .systemGray)
    private let foodPrice = UILabel().normal(text: "", ofSize: 14, weight: .regular, textColor: .systemGray)
    private let foodImage = UIImageView().customModel(contentMode: .scaleAspectFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        foodDescription.numberOfLines = 2
        foodImage.layer.cornerRadius = 10
        
        contentView.addSubview(foodTitle)
        contentView.addSubview(foodDescription)
        contentView.addSubview(foodPrice)
        contentView.addSubview(foodImage)
        
        foodImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, width: contentView.height - 40, topPadding: 20, bottomPadding: 20, rightPadding: 10)
        foodTitle.anchor(top: foodImage.topAnchor, left: contentView.leftAnchor, right: foodImage.leftAnchor, leftPadding: 10, rightPadding: 10)
        foodDescription.anchor(top: foodTitle.bottomAnchor, left: foodTitle.leftAnchor, right: foodTitle.rightAnchor, topPadding: 5)
        foodPrice.anchor(top: foodDescription.bottomAnchor, left: foodTitle.leftAnchor, right: foodTitle.rightAnchor, topPadding: 5)
    }
    
    func configure(foodTitle: String, foodDescription: String, foodPrice: Int, foodImageUrl: String) {

        self.foodTitle.text = foodTitle
        self.foodDescription.text = foodDescription
        if foodPrice == 0 {
            self.foodPrice.text = "0元起"
        }
        else {
            self.foodPrice.text = "$ \(foodPrice)"
        }
        if foodImageUrl == "" {
            foodImage.backgroundColor = .white
        }
        else {
            foodImage.backgroundColor = .systemGray6
            Nuke.loadImage(with: foodImageUrl, into: foodImage)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodPrice.text = nil
        foodTitle.text = nil
        foodImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.addBoard(edge: .top, color: .systemGray6, thickness: 1, bottomPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
