//
//  HomeCollectionViewCellSectionFive.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/7.
//

import UIKit

class HomeCollectionViewCellSectionFive: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCellSectionFive"
    
    private let imageView1 = UIImageView().customModel(contentMode: .scaleToFill)
    private let imageView2 = UIImageView().customModel(contentMode: .scaleToFill)
    private let imageView3 = UIImageView().customModel(contentMode: .scaleToFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        imageView1.image = UIImage(named: "美食金")
        imageView2.image = UIImage(named: "挑戰")
        imageView3.image = UIImage(named: "評分")
        
        contentView.addSubview(imageView1)
        contentView.addSubview(imageView2)
        contentView.addSubview(imageView3)
        
        imageView1.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 80, leftPadding: 15, rightPadding: 15)
        imageView2.anchor(top: imageView1.bottomAnchor, left: imageView1.leftAnchor, right: imageView1.rightAnchor, height: 80, topPadding: 20)
        imageView3.anchor(top: imageView2.bottomAnchor, bottom: bottomAnchor, left: imageView1.leftAnchor, right: imageView1.rightAnchor, topPadding: 20, bottomPadding: 10)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
