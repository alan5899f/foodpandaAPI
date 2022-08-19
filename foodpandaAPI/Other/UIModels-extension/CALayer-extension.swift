//
//  CALayer-extension.swift
//  CALayer-extension
//
//  Created by 陳韋綸 on 2022/5/25.
//

import Foundation
import QuartzCore
import UIKit

extension CALayer {
    
    func addBoard(edge: UIRectEdge, color: UIColor, thickness: CGFloat, bottomPadding: CGFloat) {
        
        let borders = CALayer()
        
        switch edge {
        case .top:
            borders.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            borders.frame = CGRect(x: bottomPadding, y: frame.height-thickness, width: frame.width-(2*bottomPadding), height: thickness)
        case .left:
            borders.frame = CGRect(x: 0, y: thickness, width: thickness, height: frame.height-thickness*2)
        case .right:
            borders.frame = CGRect(x: frame.width-thickness, y: 0, width: thickness, height: frame.height-thickness*2)
        default:
            break
        }
        
        borders.backgroundColor = color.cgColor
        self.addSublayer(borders)
    }
}
