//
//  OrderedViewController.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/8/11.
//

import UIKit
import CoreData
import Nuke

class OrderedViewController: UIViewController {
    
    private var ordered = [Ordered]()
    private let customView = UILabel().normal(text: "", ofSize: 14, weight: .medium, textColor: .black)
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(OrderedViewTableViewCell.self, forCellReuseIdentifier: OrderedViewTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let noOrderView = NoOrderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        view.addSubview(tableView)
        view.addSubview(noOrderView)
        noOrderView.delegate = self
        noOrderView.isHidden = false
        fetchOrderedData()
    }
    
    @objc private func didTapBack() {
        dismiss(animated: true)
    }
    
    private func setupNavBar() {
        
        customView.numberOfLines = 2
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(didTapBack)),
            UIBarButtonItem(customView: customView)
        ]
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
        
    }
    
    private func fetchOrderedData() {
        DataPersistenceManager.shared.fetchingOrderFromDatabase { [weak self] results in
            switch results {
            case .success(let ordered):
                self?.ordered = ordered
                if ordered.isEmpty {
                    self?.customView.text = "購物車"
                    self?.noOrderView.isHidden = false
                }
                else {
                    self?.customView.text = "購物車\n\(String(describing: ordered[0].resName!))"
                    self?.noOrderView.isHidden = true
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noOrderView.frame = tableView.bounds
    }
}

extension OrderedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderedViewTableViewCell.identifier, for: indexPath) as? OrderedViewTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(model: ordered[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let model = ordered[indexPath.row]
            DataPersistenceManager.shared.deleteOrderWith(model: model) { [weak self] results in
                switch results {
                case .success():
                    print("success")
                case .failure(let error):
                    print(error)
                }
                self?.ordered.remove(at: indexPath.row)
                self?.tableView.deleteRows(at: [indexPath], with: .fade)
                if self?.ordered == [] {
                    self?.dismiss(animated: true)
                }
            }
        default:
            break
        }
    }
}

extension OrderedViewController: NoOrderViewDelegate {
    
    func dismissButton() {
        dismiss(animated: true)
    }
}
