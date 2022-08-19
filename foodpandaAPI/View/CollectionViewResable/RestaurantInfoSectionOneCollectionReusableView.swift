//
//  RestaurantInfoCollectionReusableView.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/13.
//

import UIKit

class RestaurantInfoSectionOneCollectionReusableView: UICollectionReusableView {
        
    static let idnetifier = "RestaurantInfoSectionOneCollectionReusableView"
    
    let imageView = UIImageView().customModel(contentMode: .scaleAspectFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.backgroundColor = .systemGray6
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupLayout() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor)
    }
}
