//
//  OrderFoodBottomView.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/8/3.
//

import UIKit

protocol OrderFoodBottomViewDelegate: AnyObject {
    func didTapSend(count: Int, price: Int)
    func didTapCount(count: Int)
}
 
class OrderFoodBottomView: UIView {

    private let minusButton = UIButton(type: .system).normal(system: "minus", size: 16, tintColor: .white)
    private let currentOrderCount = UILabel().normal(text: "", ofSize: 20, weight: .medium, textColor: .black)
    private let plusButton = UIButton(type: .system).normal(system: "plus", size: 16, tintColor: .white)
    private let sendButton = UIButton(type: .system).normal(title: "加入購物車", titleColor: .white, ofSize: 16, weight: .medium)
    
    weak var delegate: OrderFoodBottomViewDelegate?
    
    private var count: Int = 1 {
        willSet {
            if newValue <= 1 {
                minusButton.backgroundColor = .systemGray3
                minusButton.isEnabled = false
            }
            else {
                minusButton.backgroundColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
                minusButton.isEnabled = true
            }
        }
        didSet {
            price = count * price
            currentOrderCount.text = "\(count)"
        }
    }
    
    var price = 0
    
    public var fullScreen: Bool = true {
        didSet {
            if fullScreen {
                sendButton.backgroundColor = .systemGray3
                sendButton.isEnabled = false
            }
            else {
                sendButton.backgroundColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
                sendButton.isEnabled = true
            }
        }
    }
    
    init(frame: CGRect, fullScreen: Bool) {
        self.fullScreen = fullScreen
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        setupBinding()
    }
    
    private func setupBinding() {
        if fullScreen {
            sendButton.backgroundColor = .systemGray3
            sendButton.isEnabled = false
        }
        
        minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
    }
    
    func configure(price: Int) {
        self.price = price
        print(price)
    }
    
    @objc private func didTapSend() {
        delegate?.didTapSend(count: count, price: price)
    }
    
    @objc private func didTapMinus() {
        count -= 1
        delegate?.didTapCount(count: count)
    }
    
    @objc private func didTapPlus() {
        count += 1
        delegate?.didTapCount(count: count)
    }
    
    private func setupLayout() {
        minusButton.backgroundColor = .systemGray3
        minusButton.isEnabled = false
        [plusButton, sendButton].forEach({$0.backgroundColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)})
        currentOrderCount.textAlignment = .center
        currentOrderCount.text = "\(count)"
        
        addSubview(minusButton)
        addSubview(currentOrderCount)
        addSubview(plusButton)
        addSubview(sendButton)
        
        minusButton.anchor(top: topAnchor, left: leftAnchor, width: 40, height: 40, topPadding: 20, leftPadding: 20)
        currentOrderCount.anchor(top: minusButton.topAnchor, left: minusButton.rightAnchor, width: 50, height: 40)
        plusButton.anchor(top: minusButton.topAnchor, left: currentOrderCount.rightAnchor, width: 40, height: 40)
        sendButton.anchor(left: plusButton.rightAnchor, right: rightAnchor, centerY: minusButton.centerYAnchor, height: 50, leftPadding: 20, rightPadding: 20)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.addBoard(edge: .top, color: .systemGray6, thickness: 1, bottomPadding: 0)
        sendButton.layer.cornerRadius = 10
        [minusButton, plusButton].forEach { button in
            button.layer.cornerRadius = button.width / 2
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
