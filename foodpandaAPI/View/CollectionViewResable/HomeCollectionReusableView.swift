//
//  HomeCollectionReusableView.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/6.
//

import UIKit

class HomeCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "HomeCollectionReusableView"
    
    let sectionLabel = UILabel().normal(text: "", ofSize: 20, weight: .medium, textColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(sectionLabel)
        sectionLabel.anchor(bottom: bottomAnchor, left: leftAnchor, bottomPadding: 15, leftPadding: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
