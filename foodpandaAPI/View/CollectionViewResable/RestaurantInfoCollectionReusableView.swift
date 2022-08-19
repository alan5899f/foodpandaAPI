//
//  HomeCollectionReusableViewDiscount.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/7.
//

import UIKit

class RestaurantInfoCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "RestaurantInfoCollectionReusableView"
    let background = UIView()
    let sectionLabel = UILabel().normal(text: "", ofSize: 24, weight: .bold, textColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        background.backgroundColor = .systemGray6
        backgroundColor = .white
        addSubview(background)
        addSubview(sectionLabel)
        background.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 20)
        sectionLabel.anchor(top: background.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, topPadding: 10, bottomPadding: 15, leftPadding: 15)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
