//
//  FoodDiscountCollectionReusableView.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/12.
//

import UIKit

class FoodDiscountCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "FoodDiscountCollectionReusableView"

    let imageView = UIImageView().customModel(contentMode: .scaleToFill)
    let sectionLabel = UILabel().normal(text: "", ofSize: 20, weight: .medium, textColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 20
        
        addSubview(imageView)
        addSubview(sectionLabel)
        
        sectionLabel.anchor(bottom: bottomAnchor, left: leftAnchor, bottomPadding: 10, leftPadding: 15)
        imageView.anchor(top: topAnchor, bottom: sectionLabel.topAnchor, left: leftAnchor, right: rightAnchor, topPadding: 15, bottomPadding: 15, leftPadding: 15, rightPadding: 15)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sectionLabel.text = nil
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
