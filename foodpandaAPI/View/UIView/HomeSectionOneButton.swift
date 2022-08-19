//
//  HomeSectionOneButton.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/6.
//

import UIKit

enum HomeButtonType {
    case button1
    case button2
    case button3
    case button4
}

class HomeSectionOneButton: UIView {

    private let titleLabel = UILabel().normal(text: "", ofSize: 24, weight: .bold, textColor: .black)
    private let describeLabel = UILabel().normal(text: "", ofSize: 14, weight: .regular, textColor: .gray)
    private let titleImage = UIImageView().customModel(contentMode: .scaleAspectFit)
    
    private var type: HomeButtonType
    
    init(type: HomeButtonType) {
        self.type = type
        super.init(frame: .zero)
        setupLayout()
    }
    
    private func setupLayout() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.8
        layer.borderColor = UIColor.systemGray3.cgColor
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(describeLabel)
        addSubview(titleImage)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, topPadding: 10, leftPadding: 15)
        describeLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type {
        case .button1:
            titleImage.image = UIImage(named: "button1")
            titleLabel.text = "美食外送"
            describeLabel.text = "訂購你喜愛的美食"
            titleImage.anchor(bottom: bottomAnchor, right: rightAnchor, width: height * 0.8, height: height * 0.8, bottomPadding: 5, rightPadding: 5)
        case .button2:
            titleImage.image = UIImage(named: "button2")
            titleLabel.text = "生鮮雜貨"
            describeLabel.text = "一鍵採買"
            titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
            titleImage.anchor(bottom: bottomAnchor, right: rightAnchor, width: height * 0.6, height: height * 0.6, bottomPadding: 5, rightPadding: 5)
        case .button3:
            titleImage.image = UIImage(named: "button3")
            titleLabel.text = "熊貓超市"
            describeLabel.text = "滿額省$200"
            titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
            titleImage.anchor(bottom: bottomAnchor, right: rightAnchor, width: height * 0.7, height: height * 0.7, bottomPadding: 0, rightPadding: 0)
        case .button4:
            titleImage.image = UIImage(named: "button4")
            titleLabel.text = "外帶自取"
            describeLabel.text = "最低79折起"
            titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
            titleImage.anchor(bottom: bottomAnchor, right: rightAnchor, width: height * 0.9, height: height * 0.9, bottomPadding: 0, rightPadding: 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
