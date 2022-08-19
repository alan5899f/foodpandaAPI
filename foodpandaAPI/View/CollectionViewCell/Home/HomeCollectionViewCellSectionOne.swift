//
//  HomeCollectionViewCellSectionOne.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/6.
//

import UIKit

protocol HomeCollectionViewCellSectionOneDelegate: AnyObject {
    func didTapFoodDelivery()
    func didTapFresh()
    func didTapSuperMarket()
    func didTapFoodTakeOut()
}

class HomeCollectionViewCellSectionOne: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCellSectionOne"
    
    private let button1 = HomeSectionOneButton(type: .button1)
    private let button2 = HomeSectionOneButton(type: .button2)
    private let button3 = HomeSectionOneButton(type: .button3)
    private let button4 = HomeSectionOneButton(type: .button4)
    
    weak var delegate: HomeCollectionViewCellSectionOneDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        setupLayout()
        setupBinding()
    }
    
    private func setupLayout() {
        contentView.addSubview(button1)
        contentView.addSubview(button2)
        contentView.addSubview(button3)
        contentView.addSubview(button4)
        button1.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, height: contentView.height / 2 - 20, topPadding: 10, leftPadding: 15, rightPadding: 15)
        button2.anchor(top: button1.bottomAnchor, left: button1.leftAnchor, width: contentView.width / 2 - 20, height: contentView.height / 2 - 20, topPadding: 10)
        button3.anchor(top: button1.bottomAnchor, left: button2.rightAnchor, right: button1.rightAnchor, height: (contentView.height / 2 - 30) / 2, topPadding: 10, leftPadding: 10)
        button4.anchor(top: button3.bottomAnchor, left: button3.leftAnchor, right: button3.rightAnchor, height: (contentView.height / 2 - 30) / 2, topPadding: 10)
    }
    
    private func setupBinding() {
        [button1, button2, button3, button4].forEach({$0.isUserInteractionEnabled = true})
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(didTapFoodDelivery))
        button1.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(didTapFresh))
        button2.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(didTapSuperMarket))
        button3.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(didTapFoodTakeOut))
        button4.addGestureRecognizer(tap4)
    }
    
    @objc private func didTapFoodDelivery() {
        delegate?.didTapFoodDelivery()
    }
    
    @objc private func didTapFresh() {
        delegate?.didTapFresh()
    }
    
    @objc private func didTapSuperMarket() {
        delegate?.didTapSuperMarket()
    }
    
    @objc private func didTapFoodTakeOut() {
        delegate?.didTapFoodTakeOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
