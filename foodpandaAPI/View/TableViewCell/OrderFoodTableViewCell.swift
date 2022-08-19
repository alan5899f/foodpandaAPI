//
//  OrderFoodTableViewCell.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/8/3.
//

import UIKit

class OrderFoodTableViewCell: UITableViewCell {

    static let identifier = "OrderFoodTableViewCell"
    
    private let foodTitle = UILabel().normal(text: "", ofSize: 20, weight: .medium, textColor: .black)
    private let foodPrice = UILabel().normal(text: "", ofSize: 16, weight: .medium, textColor: .black)
    private let foodDescribe = UILabel().normal(text: "", ofSize: 15, weight: .medium, textColor: .systemGray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    private func setupLayout() {
        foodDescribe.numberOfLines = 0
        foodTitle.numberOfLines = 0
        
        contentView.addSubview(foodTitle)
        contentView.addSubview(foodPrice)
        contentView.addSubview(foodDescribe)
        
        foodPrice.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, height: 50, topPadding: 10, rightPadding: 20)
        foodTitle.anchor(top: foodPrice.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, height: 50, leftPadding: 20, rightPadding: 90)
        foodDescribe.anchor(top: foodTitle.bottomAnchor, bottom: contentView.bottomAnchor, left: foodTitle.leftAnchor, right: foodPrice.rightAnchor, bottomPadding: 20)
    }
    
    func configure(foodTitle: String, foodPrice: Int, foodDescribe: String) {
        self.foodTitle.text = foodTitle
        self.foodDescribe.text = foodDescribe
        if foodPrice == 0 {
            self.foodPrice.text = "$ 0元起"
        }
        else {
        self.foodPrice.text = "$ \(foodPrice)"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodTitle.text = nil
        foodPrice.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.addBoard(edge: .bottom, color: .systemGray6, thickness: 1, bottomPadding: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
