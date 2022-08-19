//
//  OrderedViewTableViewCell.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/8/16.
//

import UIKit
import Nuke

class OrderedViewTableViewCell: UITableViewCell {

    static let identifier = "OrderedViewTableViewCell"
    
    private let countLabel = UILabel().normal(text: "", ofSize: 18, weight: .medium, textColor: .black)
    private let foodImageView = UIImageView().customModel(contentMode: .scaleAspectFill)
    private let foodTitle = UILabel().normal(text: "", ofSize: 18, weight: .medium, textColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1))
    private let foodPrice = UILabel().normal(text: "", ofSize: 16, weight: .medium, textColor: .systemGray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        countLabel.layer.borderWidth = 1
        countLabel.layer.borderColor = UIColor.systemGray.cgColor
        countLabel.textAlignment = .center
        foodTitle.numberOfLines = 2
        foodImageView.layer.cornerRadius = 12
        
        contentView.addSubview(countLabel)
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodTitle)
        contentView.addSubview(foodPrice)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        countLabel.anchor(left: contentView.leftAnchor, centerY: contentView.centerYAnchor, width: 30, height: 30, leftPadding: 20)
        foodImageView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: countLabel.rightAnchor, width: contentView.height - 20, topPadding: 10, bottomPadding: 10, leftPadding: 20)
        foodTitle.anchor(bottom: centerYAnchor, left: foodImageView.rightAnchor, right: contentView.rightAnchor, leftPadding: 10, rightPadding: 20)
        foodPrice.anchor(top: foodTitle.bottomAnchor, left: foodImageView.rightAnchor, right: contentView.rightAnchor, leftPadding: 10, rightPadding: 20)
    }
    
    func configure(model: Ordered) {
        countLabel.text = "\(model.foodCount)"
        Nuke.loadImage(with: model.image_url, into: foodImageView)
        foodTitle.text = model.name
        foodPrice.text = "$ \(model.price)"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
