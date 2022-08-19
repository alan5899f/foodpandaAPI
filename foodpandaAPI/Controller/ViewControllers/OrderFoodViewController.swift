//
//  OrderFoodViewController.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/27.
//

import UIKit
import Nuke

class OrderFoodViewController: UIViewController {

    private var orderInfo: RestaurantInfoStrcutProducts
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(OrderFoodTableViewCell.self, forCellReuseIdentifier: OrderFoodTableViewCell.identifier)
        return tableView
    }()
    
    private var resName: String
    private var orderFoodBottomView: OrderFoodBottomView
    private var fullScreen: Bool
    private var indePath: IndexPath?
    
    private var foodCount = 1 {
        didSet {
            foodPrice = foodCount * Int(orderInfo.product_variations[0].price ?? 0.0)
            tableView.reloadData()
        }
    }
    
    private var foodPrice = 0
    
    init(orderInfo: RestaurantInfoStrcutProducts, fullScreen: Bool, resName: String) {
        self.orderInfo = orderInfo
        self.fullScreen = fullScreen
        self.resName = resName
        self.orderFoodBottomView = OrderFoodBottomView(frame: .zero, fullScreen: fullScreen)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        orderFoodBottomView.delegate = self
        setupNavBar()
        setupLayout()
        foodPrice = Int(orderInfo.product_variations[0].price ?? 0.0)
        orderFoodBottomView.configure(price: foodPrice)
    }
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .bold)), style: .done, target: self, action: #selector(didTapBack))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
    }
    
    @objc private func didTapBack() {
        dismiss(animated: true)
    }
    
    private func setupFoodImage(headerFoodImage: UIImageView) {
    
        guard orderInfo.images != [] else {
            headerFoodImage.image = UIImage(named: "預設背景")
            return
        }
        Nuke.loadImage(with: orderInfo.images?[0].image_url ?? "", into: headerFoodImage)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(orderFoodBottomView)
        orderFoodBottomView.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 130)
        tableView.anchor(top: view.topAnchor, bottom: orderFoodBottomView.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        tableView.tableHeaderView = tableViewHeader()
    }
    
    private func tableViewHeader() -> UIView {
        let header = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.width, height: 250))
        setupFoodImage(headerFoodImage: header.imageView)
        return header
    }
}

extension OrderFoodViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyTableHeaderView else {
            return
        }
        header.scrollViewDidScroll(scrollView: tableView)
    }
}

extension OrderFoodViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fullScreen == true ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fullScreen {
            switch section {
            case 0:
                return 1
            case 1:
                return orderInfo.product_variations.count
            default:
                return 0
            }
        }
        else {
            switch section {
            case 0:
                return 1
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "選擇大小"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderFoodTableViewCell.identifier, for: indexPath) as? OrderFoodTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(foodTitle: orderInfo.name, foodPrice: foodPrice, foodDescribe: orderInfo.description)
            return cell
        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            let model = orderInfo.product_variations[indexPath.row]
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = "$ \(Int(model.price ?? 0.0))"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            indePath = indexPath
            orderFoodBottomView.fullScreen = false
        }
    }
}

extension OrderFoodViewController: OrderFoodBottomViewDelegate {
    
    func didTapCount(count: Int) {
        self.foodCount = count
        orderFoodBottomView.configure(price: foodPrice)
    }
    
    func didTapSend(count: Int, price: Int) {
        DataPersistenceManager.shared.fetchingOrderFromDatabase { [weak self] results in
            switch results {
            case .success(let ordered):
                guard ordered != [] else {
                    self?.sendSucced(count: count, price: price)
                    return
                }
                ordered.forEach { order in
                    if order.resName == self?.resName {
                        self?.sendSucced(count: count, price: price)
                    }
                    else {
                        let alert = UIAlertController(title: "錯誤", message: "您已有在其他餐廳訂購", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "確定", style: .default))
                        self?.present(alert, animated: true)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func sendSucced(count: Int, price: Int) {
        DataPersistenceManager.shared.ordered(model: orderInfo, row: indePath?.row ?? 0, resName: resName, foodCount: count, price: price) { results in
            switch results {
            case .success():
                print("success")
            case .failure(let error):
                print(error)
            }
        }
        dismiss(animated: true)
    }
}
