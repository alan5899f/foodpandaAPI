//
//  UILabel-Class.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/15.
//

import Foundation
import UIKit

class RestaurantInfoLabel: UILabel {
    
    var padding: UIEdgeInsets
    
    init(padding: UIEdgeInsets, weight: UIFont.Weight, ofSize: CGFloat, textColor: UIColor) {
        self.padding = padding
        super.init(frame: .zero)
        self.font = .systemFont(ofSize: ofSize, weight: weight)
        self.textColor = textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}
