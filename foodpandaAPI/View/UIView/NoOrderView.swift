//
//  NoOrderView.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/8/16.
//

import UIKit

protocol NoOrderViewDelegate: AnyObject {
    func dismissButton()
}

class NoOrderView: UIView {
    
    weak var delegate: NoOrderViewDelegate?
    
    private let imageView = UIImageView().customModel(contentMode: .scaleAspectFit)
    private let backButton = UIButton(type: .system).normal(title: "回首頁查看", titleColor: .white, ofSize: 16, weight: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        backButton.layer.cornerRadius = 10
        backButton.backgroundColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
        imageView.image = UIImage(named: "沒有訂單")
        addSubview(imageView)
        addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }
    
    @objc private func didTapBack() {
        delegate?.dismissButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: width - 200, topPadding: height / 3, leftPadding: 100, rightPadding: 100)
        backButton.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, right: imageView.rightAnchor, height: 50, topPadding: 20, leftPadding: 20, rightPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
