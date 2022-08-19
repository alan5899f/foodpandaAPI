//
//  FoodRefreshCollectionViewCell.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/12.
//

import UIKit

class FoodRefreshCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FoodRefreshCollectionViewCell"
    
    public var refresh = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(refresh)
        refresh.frame = CGRect(x: 0, y: 0, width: contentView.width, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
