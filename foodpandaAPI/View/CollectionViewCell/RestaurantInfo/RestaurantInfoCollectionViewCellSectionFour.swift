//
//  RestaurantInfoCollectionViewCellSectionFour.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/15.
//

import UIKit

protocol RestaurantInfoCollectionViewCellSectionFourDelegate: AnyObject {
    func didTapFoodTypeButton(index: IndexPath?)
}

class RestaurantInfoCollectionViewCellSectionFour: UICollectionViewCell {
    
    static let identifier = "RestaurantInfoCollectionViewCellSectionFour"
    
    let foodTypeLabel = UILabel().normal(text: "", ofSize: 14, weight: .medium, textColor: .black)
    let lineLabel = UILabel().normal(text: "", ofSize: 0, weight: .regular, textColor: .clear)
    
    weak var delegate: RestaurantInfoCollectionViewCellSectionFourDelegate?
    
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
//        setupBinding()
    }
    
    private func setupBinding() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc private func didTap() {
        delegate?.didTapFoodTypeButton(index: indexPath)
    }
    
    private func setupLayout() {
        
        foodTypeLabel.numberOfLines = 2
        foodTypeLabel.textAlignment = .center
        lineLabel.isHidden = true
        lineLabel.backgroundColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
        lineLabel.layer.cornerRadius = 2
        lineLabel.layer.masksToBounds = true
        
        contentView.addSubview(foodTypeLabel)
        contentView.addSubview(lineLabel)
        lineLabel.anchor(bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, height: 4, leftPadding: 10, rightPadding: 10)
        foodTypeLabel.anchor(top: contentView.topAnchor, bottom: lineLabel.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, topPadding: 0, bottomPadding: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(foodTypeLabel: String) {
        self.foodTypeLabel.text = foodTypeLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
