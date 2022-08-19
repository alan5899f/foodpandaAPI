//
//  RestaurantInfoCollectionViewCellSectionTwo.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/13.
//

import UIKit

class RestaurantInfoCollectionViewCellSectionTwo: UICollectionViewCell {
    
    static let identifier = "RestaurantInfoCollectionViewCellSectionTwo"
    
    private let timeImage = UIImageView().customModel(contentMode: .scaleAspectFit)
    private let timeLabel = UILabel().normal(text: "", ofSize: 14, weight: .bold, textColor: .black)
    private let fix = UILabel().normal(text: "更改", ofSize: 14, weight: .medium, textColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        timeImage.image = UIImage(named: "時間")
        
        contentView.addSubview(timeImage)
        contentView.addSubview(timeLabel)
        contentView.addSubview(fix)
        
        timeImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, width: 30, leftPadding: 10)
        fix.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, width: 50, leftPadding: 10)
        timeLabel.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: timeImage.rightAnchor, right: fix.leftAnchor, leftPadding: 10, rightPadding: 10)
    }
    
    func configure(timeLabel: String) {
        self.timeLabel.text = timeLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
