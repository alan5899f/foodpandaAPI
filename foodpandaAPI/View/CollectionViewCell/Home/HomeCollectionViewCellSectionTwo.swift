//
//  HomeCollectionViewCellSectionTwo.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/6.
//

import UIKit
import Nuke

class HomeCollectionViewCellSectionTwo: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCellSectionTwo"
    
    private let foodImage = UIImageView().customModel(contentMode: .scaleAspectFill)
    private let foodLabel = UILabel().normal(text: "", ofSize: 16, weight: .regular, textColor: .black)
    private let foodDiscount = UILabel().normal(text: "panda專屬", ofSize: 14, weight: .bold, textColor: .white)
    
    private let foodTime = UIButton().normal(title: "", titleColor: .black, ofSize: 14, weight: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        backgroundColor = .white
        foodLabel.numberOfLines = 0
        foodImage.layer.cornerRadius = 10
        foodImage.backgroundColor = .systemGray6
        
        foodTime.isEnabled = false
        foodTime.layer.cornerRadius = 15
        foodTime.clipsToBounds = true
        foodTime.layer.masksToBounds = false
        foodTime.layer.shadowRadius = 8
        foodTime.layer.shadowOpacity = 0.2
        foodTime.layer.shadowColor = UIColor.black.cgColor
        foodTime.backgroundColor = .white
        
        foodDiscount.backgroundColor = .black
        foodDiscount.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        foodDiscount.layer.cornerRadius = 5
        foodDiscount.layer.masksToBounds = true
        foodDiscount.isHidden = false
        foodDiscount.textAlignment = .center
        
        contentView.addSubview(foodImage)
        contentView.addSubview(foodLabel)
        contentView.addSubview(foodTime)
        contentView.addSubview(foodDiscount)
        
        foodImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, height: contentView.height * 0.6, topPadding: 10, leftPadding: 15, rightPadding: 0)
        foodLabel.anchor(top: foodImage.bottomAnchor, left: foodImage.leftAnchor, right: foodImage.rightAnchor, topPadding: 10)
        foodTime.anchor(bottom: foodImage.bottomAnchor, left: foodImage.leftAnchor, width: 65, height: 30, bottomPadding: 10, leftPadding: 10)
        foodDiscount.anchor(top: foodImage.topAnchor, left: foodImage.leftAnchor, width: 80, height: 25, topPadding: 10)
    }

    func configure(title: String, describe: String, deliveryFee: String, imageUrl: String, foodTime: String, foodDiscount: Bool) {
        if foodDiscount {
            self.foodDiscount.isHidden = false
        }
        else {
            self.foodDiscount.isHidden = true
        }
        Nuke.loadImage(with: imageUrl, into: foodImage)
        self.foodTime.setTitle(foodTime, for: .normal)
        attributed(title: title, describe: describe, deliveryFee: deliveryFee)
    }
    
    private func attributed(title: String, describe: String, deliveryFee: String) {
        let stringCount1 = title.count
        let attributed1 = NSMutableAttributedString(string: title + "\n")
        attributed1.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .bold), range: NSMakeRange(0, stringCount1))
        
        let stringCount2 = describe.count
        let attributed2 = NSMutableAttributedString(string: describe + "\n")
        attributed2.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .regular), range: NSMakeRange(0, stringCount2))
        attributed2.addAttribute(.foregroundColor, value: UIColor.systemGray, range: NSMakeRange(0, stringCount2))
        
        let stringCount3 = deliveryFee.count
        let attributed3 = NSMutableAttributedString(string: deliveryFee)
        attributed3.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .medium), range: NSMakeRange(0, stringCount3))
        attributed1.append(attributed2)
        attributed1.append(attributed3)
        
        foodLabel.attributedText = attributed1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
