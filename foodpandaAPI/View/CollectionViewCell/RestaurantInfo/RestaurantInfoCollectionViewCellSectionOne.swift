//
//  RestaurantInfoCollectionViewCellSectionOne.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/13.
//

import UIKit

class RestaurantInfoCollectionViewCellSectionOne: UICollectionViewCell {
    
    static let identifier = "RestaurantInfoCollectionViewCellSectionOne"
    
    private let resNameLabel = UILabel().normal(text: "", ofSize: 16, weight: .bold, textColor: .black)
    private let resMessageLabel = UILabel().normal(text: "", ofSize: 12, weight: .regular, textColor: .systemGray)
    private let resEvaluation = UILabel().normal(text: "", ofSize: 12, weight: .regular, textColor: .systemGray)
    private let moreInfo = UILabel().normal(text: "更多詳情", ofSize: 14, weight: .medium, textColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubview(moreInfo)
        moreInfo.anchor(right: contentView.rightAnchor, centerY: contentView.centerYAnchor, width: 80, height: 50)
        
        let Vstack = UIStackView(arrangedSubviews: [resNameLabel, resMessageLabel, resEvaluation])
        contentView.addSubview(Vstack)
        Vstack.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: moreInfo.leftAnchor, topPadding: 10, leftPadding: 10)
        Vstack.axis = .vertical
        Vstack.distribution = .fillEqually
    }
    
    func configure(resNameLabel: String, resMessageLabel: String, resEvaluation: String) {
        self.resNameLabel.text = resNameLabel
        self.resMessageLabel.text = resMessageLabel
        self.resEvaluation.text = resEvaluation
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
