//
//  HomeMenuView.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/7.
//

import UIKit

protocol HomeMenuViewDelegate: AnyObject {
    func currentAddress()
    func newAddress()
}

class HomeMenuView: UIView {
    
    private let button1 = UIButton().normal(title: "使用我目前的地址", titleColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1), ofSize: 16, weight: .bold)
    private let button2 = UIButton().normal(title: "新地址", titleColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1), ofSize: 16, weight: .bold)
    
    weak var delegate: HomeMenuViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupBinding()
    }
    
    private func setupBinding() {
        button1.addTarget(self, action: #selector(didTapCurrentAddress), for: .touchUpInside)
        button2.addTarget(self, action: #selector(didTapNewAddress), for: .touchUpInside)
    }
    
    @objc private func didTapCurrentAddress() {
        delegate?.currentAddress()
    }
    
    @objc private func didTapNewAddress() {
        delegate?.newAddress()
    }
    
    private func setupLayout() {
        backgroundColor = .white
        var configure = UIButton.Configuration.tinted()
        configure.image = UIImage(systemName: "location")
        configure.imagePadding = 10
        configure.baseBackgroundColor = .clear
        configure.imagePlacement = .leading
        button1.configuration = configure
        button1.tintColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
        var configure2 = UIButton.Configuration.tinted()
        configure2.image = UIImage(systemName: "plus")
        configure2.imagePadding = 10
        configure2.baseBackgroundColor = .clear
        configure2.imagePlacement = .leading
        button2.configuration = configure2
        button2.tintColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
        button1.contentHorizontalAlignment = .left
        button2.contentHorizontalAlignment = .left
        let Vstack = UIStackView(arrangedSubviews: [button1, button2])
        Vstack.axis = .vertical
        Vstack.spacing = 10
        Vstack.distribution = .fillEqually
        addSubview(Vstack)
        Vstack.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 10, leftPadding: 30, rightPadding: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
