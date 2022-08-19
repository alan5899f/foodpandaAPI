//
//  MapAddressLabelViewController.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/8.
//

import UIKit

protocol MapAddressViewDelegate: AnyObject {
    func didTapSaveAddress()
}

class MapAddressView: UIView {

    private let image = UIImageView().customModel(contentMode: .scaleAspectFit)
    let address1 = UILabel().normal(text: "", ofSize: 18, weight: .medium, textColor: .black)
    let address2 = UILabel().normal(text: "", ofSize: 14, weight: .regular, textColor: .systemGray)
    private let button = UIButton(type: .system).normal(system: "pencil", size: 16, tintColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1), weight: .heavy)
    private let line = UILabel()
    
    private let addAddressButton = UIButton(type: .system).normal(title: "儲存地址", titleColor: .white, ofSize: 14, weight: .bold)
    
    weak var delegate: MapAddressViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.masksToBounds = true
        setupLayout()
        setupBinding()
    }
    
    private func setupBinding() {
        addAddressButton.addTarget(self, action: #selector(didTapSaveAddress), for: .touchUpInside)
    }
    
    @objc private func didTapSaveAddress() {
        delegate?.didTapSaveAddress()
    }
    
    private func setupLayout() {
        line.backgroundColor = .systemGray6
        image.image = UIImage(named: "地標3")
        addAddressButton.backgroundColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
        addAddressButton.layer.cornerRadius = 10
        
        addSubview(image)
        addSubview(address1)
        addSubview(address2)
        addSubview(button)
        addSubview(line)
        addSubview(addAddressButton)
        
        line.anchor(left: leftAnchor, right: rightAnchor, centerY: centerYAnchor, height: 1)
        image.anchor(top: topAnchor, bottom: line.topAnchor, left: leftAnchor, width: 50, leftPadding: 15)
        button.anchor(top: topAnchor, bottom: line.topAnchor, right: rightAnchor, width: 50, rightPadding: 15)
        address1.anchor(bottom: image.centerYAnchor, left: image.rightAnchor, right: button.leftAnchor, leftPadding: 10, rightPadding: 10)
        address2.anchor(top: image.centerYAnchor, left: address1.leftAnchor, right: address1.rightAnchor, topPadding: 5)
        addAddressButton.anchor(top: line.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 15, bottomPadding: 35, leftPadding: 15, rightPadding: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
