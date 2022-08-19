//
//  UIButton-extension.swift
//  UIButton-extension
//
//  Created by 陳韋綸 on 2022/5/25.
//

import UIKit

extension UIButton {
    
    func normal(system: String, size: CGFloat, tintColor: UIColor, weight: UIImage.SymbolWeight? = nil) -> UIButton {
        setImage(UIImage(systemName: system)?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: size, weight: weight ?? .regular))?.withTintColor(tintColor, renderingMode: .alwaysOriginal), for: .normal)
        layer.masksToBounds = true
        return self
    }
    
    func normal(title: String, titleColor: UIColor, ofSize: CGFloat, weight: UIFont.Weight) -> UIButton {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = .systemFont(ofSize: ofSize, weight: weight)
        layer.masksToBounds = true
        return self
    }
    
    func imageAndTitle(system: String, title: String, pointSize: CGFloat, tintColor: UIColor) -> UIButton {
        var config = UIButton.Configuration.tinted()
        var button = UIButton()
        config.title = title
        config.image = UIImage(systemName: system)?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: pointSize))
        config.imagePlacement = .leading
        config.imagePadding = 10
        config.baseBackgroundColor = .clear
        button = UIButton(configuration: config, primaryAction: nil)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = tintColor
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }
    
    func leftNavBarStyle(tintColor: UIColor, selectColor: UIColor, selectedColor: UIColor, systemImageName: String, width: CGFloat, height: CGFloat) -> UIButton {
        
        let config1 = UIImage.SymbolConfiguration(paletteColors: [selectedColor, .white])
        let config2 = UIImage.SymbolConfiguration(paletteColors: [selectColor, .white])
        let backImage = UIImage(systemName: systemImageName)?.withConfiguration(config1)
        let backImageSelect = UIImage(systemName: systemImageName)?.withConfiguration(config2)
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: height))
        backButton.setBackgroundImage(backImage, for: .normal)
        backButton.setBackgroundImage(backImageSelect, for: .highlighted)
        return backButton
    }
}
