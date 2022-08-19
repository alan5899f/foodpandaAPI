//
//  HomeCollectionReusableViewDiscount.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/7.
//

import UIKit

class HomeCollectionReusableViewDiscount: UICollectionReusableView {
        
    static let identifier = "HomeCollectionReusableViewDiscount"
    private let imageView = UIImageView().customModel(contentMode: .scaleToFill)
    private let sectionLabel = UILabel().normal(text: "精選優惠", ofSize: 20, weight: .medium, textColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        imageView.image = UIImage(named: "付費")
        
        addSubview(imageView)
        addSubview(sectionLabel)
        
        sectionLabel.anchor(bottom: bottomAnchor, left: leftAnchor, bottomPadding: 10, leftPadding: 15)
        imageView.anchor(bottom: sectionLabel.topAnchor, left: leftAnchor, right: rightAnchor, height: 80, bottomPadding: 10, leftPadding: 15, rightPadding: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
