//
//  RestaurantInfoCollectionViewCellSectionThree.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/14.
//

import UIKit

class RestaurantInfoCollectionViewCellSectionThree: UICollectionViewCell {
    
    static let identifier = "RestaurantInfoCollectionViewCellSectionThree"
    
    private let discountLabel = RestaurantInfoLabel(padding: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15), weight: .bold, ofSize: 14, textColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        
        discountLabel.backgroundColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
        discountLabel.layer.cornerRadius = 10
        discountLabel.layer.masksToBounds = true
        discountLabel.numberOfLines = 3
        
        contentView.addSubview(discountLabel)

        discountLabel.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, topPadding: 10, bottomPadding: 10, leftPadding: 10, rightPadding: 10)
    }
    
    func configure(name: String, description: String) {
        let nameCount = name.count
        let nameAtt = NSMutableAttributedString(string: name + "\n")
        nameAtt.addAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .bold)], range: NSMakeRange(0, nameCount))
        let descriptionCount = description.count
        let descriptionAtt = NSMutableAttributedString(string: description)
        descriptionAtt.addAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .bold)], range: NSMakeRange(0, descriptionCount))
        nameAtt.append(descriptionAtt)
        self.discountLabel.attributedText = nameAtt
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
