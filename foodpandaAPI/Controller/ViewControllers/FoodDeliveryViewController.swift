//
//  FoodDeliveryViewController.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/8.
//

import UIKit

enum PageStatus {
    case Loading
    case NotLoading
}

class FoodDeliveryViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { index, _  in
            if index == 0 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
                let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: Hgroup)
                section.orthogonalScrollingBehavior = .continuous
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                return section
            }
            if index == 1 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
                let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.25)), subitems: [item])
                let section = NSCollectionLayoutSection(group: Hgroup)
                section.orthogonalScrollingBehavior = .continuous
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            }
            if index == 2 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
                let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.25)), subitems: [item])
                let section = NSCollectionLayoutSection(group: Hgroup)
                section.orthogonalScrollingBehavior = .continuous
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            }
            if index >= 3, index <= self.datasArray.count + 2 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
                let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.25)), subitems: [item])
                let section = NSCollectionLayoutSection(group: Hgroup)
                section.orthogonalScrollingBehavior = .continuous
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                return section
            }
            if index == self.datasArray.count + 3 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 1, bottom: 1, trailing: 0)
                let Vgroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25)), subitems: [item])
                let section = NSCollectionLayoutSection(group: Vgroup)

                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                return section
            }
            if index == self.datasArray.count + 4 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let Vgroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), subitems: [item])
                let section = NSCollectionLayoutSection(group: Vgroup)
                return section
            }
            return nil
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeCollectionViewCellSectionFour.self, forCellWithReuseIdentifier: HomeCollectionViewCellSectionFour.identifier)
        collectionView.register(FoodDeliveryCollectionViewCellSectionTwo.self, forCellWithReuseIdentifier: FoodDeliveryCollectionViewCellSectionTwo.identifier)
        collectionView.register(FoodDeliveryCollectionViewCellSectionThree.self, forCellWithReuseIdentifier: FoodDeliveryCollectionViewCellSectionThree.identifier)
        collectionView.register(FoodRefreshCollectionViewCell.self, forCellWithReuseIdentifier: FoodRefreshCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // header
        collectionView.register(HomeCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionReusableView.identifier)
        collectionView.register(FoodDiscountCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FoodDiscountCollectionReusableView.identifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cell")
        return collectionView
    }()
    
    private var pageStatus: PageStatus = .NotLoading
    private var pageStatusLimit: Int = 10
    
    private var categoryData: CategoryStruct?
    
    private var datasArray = [RecommendStructTitle]()
    private var datasAllResArray: NearbyResStruct?
    
    private var street: String
    private var longitude: Double
    private var latitude: Double
    
    init(street: String, longitude: Double, latitude: Double) {
        self.street = street
        self.latitude = latitude
        self.longitude = longitude
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navBarButton(title: "美食外送", addressStreet: street)
        setupLayout()
        setupAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarStyle()
    }
    
    private func setupAPI() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        CatchAPI.shared.catchNearbyRes(limit: pageStatusLimit, longitude: longitude, latitude: latitude) { [weak self] data in
            DispatchQueue.main.async {
                self?.datasAllResArray = data
                group.leave()
            }
        }
        CatchAPI.shared.catchRecommendRes(limit: 1, longitude: longitude, latitude: latitude) { [weak self] data in
            DispatchQueue.main.async {
                data.data.items.forEach({ items in
                    let header = items.headline
                    let vendor = items.vendors
                    if header == "優惠主打星⭐", items.vendors != [] {
                        self?.datasArray.append(RecommendStructTitle(title: header, vendors: vendor))
                    }
                    if header == "深夜食堂 溫暖心房", items.vendors != [] {
                        self?.datasArray.append(RecommendStructTitle(title: header, vendors: vendor))
                    }
                    if header == "附近熱門餐廳", items.vendors != [] {
                        if items.vendors == [] {
                            return
                        }
                        self?.datasArray.append(RecommendStructTitle(title: header, vendors: vendor))
                    }
                    if header == "新餐廳", items.vendors != [] {
                        self?.datasArray.append(RecommendStructTitle(title: header, vendors: vendor))
                    }
                    if header == "超人氣餐廳", items.vendors != [] {
                        self?.datasArray.append(RecommendStructTitle(title: header, vendors: vendor))
                    }
                    if header == "買一送一 兩倍快樂優惠專區🥂", items.vendors != [] {
                        self?.datasArray.append(RecommendStructTitle(title: header, vendors: vendor))
                    }
                    if header == "飲料專區🍹", items.vendors != [] {
                        self?.datasArray.append(RecommendStructTitle(title: header, vendors: vendor))
                    }
                })
                self!.collectionView.reloadData()
                group.leave()
            }
        }
        CatchAPI.shared.catchCategory { [weak self] data in
            DispatchQueue.main.async {
                self?.categoryData = data
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    private func setupLayout() {
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    private func setupNavBarStyle() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    private func navBarButton(title: String, addressStreet: String) {
        // NSMutableAttributedString
        let address = UILabel()
        address.sizeToFit()
        address.numberOfLines = 2
        let addressTitleCount = title.count
        let addressTitle = NSMutableAttributedString(string: title + "\n")
        addressTitle.addAttributes([.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 14, weight: .medium)], range: NSMakeRange(0, addressTitleCount))
        let addressTitleCount2 = addressStreet.count
        let addressTitle2 = NSMutableAttributedString(string: addressStreet)
        addressTitle2.addAttributes([.foregroundColor: UIColor.systemGray, .font: UIFont.systemFont(ofSize: 12, weight: .regular)], range: NSMakeRange(0, addressTitleCount2))
        addressTitle.append(addressTitle2)
        
        address.attributedText = addressTitle
        
        address.isUserInteractionEnabled = true
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(didTapBack)),
            UIBarButtonItem(customView: address)
        ]
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bag"), style: .done, target: self, action: #selector(didTapMyOrderedShop)),
            UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(didTapCollection))
        ]
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
        navigationItem.rightBarButtonItems?.forEach({$0.tintColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)})
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapMyOrderedShop() {
        let vc = OrderedViewController()
        let navvc = UINavigationController(rootViewController: vc)
        navvc.modalPresentationStyle = .fullScreen
        present(navvc, animated: true)
    }
    
    @objc private func didTapCollection() {
        
    }
}

extension FoodDeliveryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch pageStatus {
        case .Loading:
            return 3 + datasArray.count + 2
        case .NotLoading:
            return 3 + datasArray.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch pageStatus {
        case .Loading:
            if section == 0 {
                return categoryData?.discount.count ?? 0
            }
            if section == 1 {
                guard datasArray == [] else {
                    return datasArray[0].vendors.count
                }
                return 0
            }
            if section == 2 {
                return categoryData?.filters.count ?? 0
            }
            for y in 0..<datasArray.count {
                let x = y + 3
                if section == x {
                    guard datasArray == [] else {
                        return datasArray[y].vendors.count
                    }
                    return 0
                }
            }
            if section == 3 + datasArray.count {
                return datasAllResArray?.data.items.count ?? 0
            }
            if section == 3 + datasArray.count + 1 {
                return 1
            }
        case .NotLoading:
            if section == 0 {
                return categoryData?.discount.count ?? 0
            }
            if section == 1 {
                guard datasArray == [] else {
                    return datasArray[0].vendors.count
                }
                return 0
            }
            if section == 2 {
                return categoryData?.filters.count ?? 0
            }
            for y in 0..<datasArray.count {
                let x = y + 3
                if section == x {
                    guard datasArray == [] else {
                        return datasArray[y].vendors.count
                    }
                    return 0
                }
            }
            if section == 3 + datasArray.count {
                return datasAllResArray?.data.items.count ?? 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellSectionFour.identifier, for: indexPath) as? HomeCollectionViewCellSectionFour else {
                return UICollectionViewCell()
            }
            let imageUrl = categoryData?.discount[indexPath.row].url ?? ""
            cell.configure(imageUrl: imageUrl)
            return cell
        }
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodDeliveryCollectionViewCellSectionTwo.identifier, for: indexPath) as? FoodDeliveryCollectionViewCellSectionTwo else {
                return UICollectionViewCell()
            }
            guard datasArray == [] else {
                return cellModelSectionTwo(cell: cell, datas: datasArray[0].vendors , indexPath: indexPath)
            }
            return cell
        }
        if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodDeliveryCollectionViewCellSectionThree.identifier, for: indexPath) as? FoodDeliveryCollectionViewCellSectionThree else {
                return UICollectionViewCell()
            }
            let title = categoryData?.filters[indexPath.row].title ?? ""
            let imageUrl = categoryData?.filters[indexPath.row].url ?? ""
            cell.configure(title: title, imageUrl: imageUrl)
            return cell
        }
        if indexPath.section >= 3, indexPath.section < datasArray.count + 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodDeliveryCollectionViewCellSectionTwo.identifier, for: indexPath) as? FoodDeliveryCollectionViewCellSectionTwo else {
                return UICollectionViewCell()
            }
            for x in 3..<datasArray.count + 3 {
                if indexPath.section == x {
                    return cellModelSectionTwo(cell: cell, datas: datasArray[x - 3].vendors, indexPath: indexPath)
                }
            }
            return cell
        }
        if indexPath.section == 3 + datasArray.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodDeliveryCollectionViewCellSectionTwo.identifier, for: indexPath) as? FoodDeliveryCollectionViewCellSectionTwo else {
                return UICollectionViewCell()
            }
            return cellModelSectionTwo(cell: cell, datas: datasAllResArray?.data.items ?? [], indexPath: indexPath)
        }
        if indexPath.section == 3 + datasArray.count + 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodRefreshCollectionViewCell.identifier, for: indexPath) as? FoodRefreshCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.refresh.startAnimating()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cell", for: indexPath)
        
        if indexPath.section >= 1, indexPath.section < 3 + datasArray.count {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionReusableView.identifier, for: indexPath) as? HomeCollectionReusableView else {
                return UICollectionReusableView()
            }
            if indexPath.section == 1 {
                guard datasArray == [] else {
                    guard datasArray == [] else {
                        header.sectionLabel.text = "重新下訂"
                        return header
                    }
                    return header
                }
                return header
            }
            if indexPath.section == 2 {
                guard datasArray == [] else {
                    header.sectionLabel.text = "在家吃遍全世界"
                    return header
                }
                return header
            }
            for y in 0..<datasArray.count {
                let x = y + 3
                if indexPath.section == x {
                    guard datasArray == [] else {
                        header.sectionLabel.text = datasArray[y].title
                        return header
                    }
                    return header
                }
            }
        }
        guard datasArray == [] else {
            if indexPath.section == 3 + datasArray.count {
                guard let discountHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FoodDiscountCollectionReusableView.identifier, for: indexPath) as? FoodDiscountCollectionReusableView else {
                    return UICollectionReusableView()
                }
                discountHeader.sectionLabel.text = "所有餐廳"
                discountHeader.imageView.image = UIImage(named: "領美食金")
                return discountHeader
            }
            return cell
        }
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView.contentSize.height < scrollView.contentOffset.y + scrollView.height - 50, pageStatus == .NotLoading else { return }
        pageStatus = .Loading
        collectionView.reloadData()
        
        pageStatusLimit += 10
        CatchAPI.shared.catchNearbyRes(limit: pageStatusLimit, longitude: longitude, latitude: latitude) { [weak self] data in
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.pageStatus = .NotLoading
                    self?.datasAllResArray = data
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vendor: RecommendStructVendors!
        if indexPath.section == 0 {
            return
        }
        if indexPath.section == 1 {
            vendor = datasArray[0].vendors[indexPath.row]
        }
        if indexPath.section == 2 {
            return
        }
        for y in 0..<datasArray.count {
            let x = y + 3
            if indexPath.section == x {
               vendor = datasArray[y].vendors[indexPath.row]
            }
        }
        if indexPath.section == 3 + datasArray.count {
            vendor = datasAllResArray?.data.items[indexPath.row]
        }
        resInfoPageSetupNavBarStyle(navigationController: navigationController) { [weak self] done in
            if done {
                DispatchQueue.main.async {
                    let vc = RestaurantInfoViewController(resVendor: vendor)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

extension FoodDeliveryViewController {
    
    private func cellModelSectionTwo(cell: FoodDeliveryCollectionViewCellSectionTwo, datas: [RecommendStructVendors?], indexPath: IndexPath) -> FoodDeliveryCollectionViewCellSectionTwo {
        let model = datas[indexPath.row]
        let title = model?.name ?? ""
        let imageUrl = model?.hero_listing_image ?? ""
        
        let foodTimeDouble = model?.minimum_delivery_time ?? 0.0
        let foodTime = "\(Int(foodTimeDouble)) min"
        
        let deliveryFeeDouble = model?.minimum_delivery_fee ?? 0.0
        let deliveryFee = "$ \(Int(deliveryFeeDouble)) 外送服務費"
        
        let foodDiscountValue = model?.food_characteristics
        
        var describe: String = ""
        var foodDiscountBool = false
        
        if model?.budget == 1 {
            describe = "$ • "
        }
        if model?.budget == 2 {
            describe = "$$ • "
        }
        if model?.budget == 3 {
            describe = "$$$ • "
        }
        model?.cuisines.forEach({ cuisines in
            describe += cuisines.name + ","
        })
        if foodDiscountValue == [] {
            foodDiscountBool = false
        }
        else {
            foodDiscountBool = true
        }
        cell.configure(title: title, describe: describe, deliveryFee: deliveryFee, imageUrl: imageUrl, foodTime: foodTime, foodDiscount: foodDiscountBool)
        return cell
    }
}
