//
//  RestaurantInfoViewController.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/12.
//

import UIKit
import Nuke

enum Discount {
    case True
    case False
    case none
}

class RestaurantInfoViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { index,_ in
            if index == 0 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                return section
            }
            if index == 1 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
            switch self.discount {
            case .True:
                if index == 2 {
                    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                    let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
                    return section
                }
                // 食物選單
                if index == 3 {
                    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(50)), subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .continuous
                    return section
                }
                if index == 4 {
                    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5)), subitem: item, count: 2)
                    let section = NSCollectionLayoutSection(group: group)
                    return section
                }
                if index >= 5, index <= 5 + (self.resInfo?.data.menus[0].menu_categories.count ?? 0) {
                    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                    let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170)), subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
                    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                    section.boundarySupplementaryItems = [header]
                    return section
                }
            case .False:
                // 食物選單
                if index == 2 {
                    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(50)), subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .continuous
                    return section
                }
                if index == 3 {
                    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5)), subitem: item, count: 2)
                    let section = NSCollectionLayoutSection(group: group)
                    return section
                }
                if index >= 4, index <= 4 + (self.resInfo?.data.menus[0].menu_categories.count ?? 0) {
                    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                    let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170)), subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
                    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                    section.boundarySupplementaryItems = [header]
                    return section
                }
            case .none:
                return nil
            }
            return nil
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(RestaurantInfoCollectionViewCellSectionOne.self, forCellWithReuseIdentifier: RestaurantInfoCollectionViewCellSectionOne.identifier)
        collectionView.register(RestaurantInfoCollectionViewCellSectionTwo.self, forCellWithReuseIdentifier: RestaurantInfoCollectionViewCellSectionTwo.identifier)
        collectionView.register(RestaurantInfoCollectionViewCellSectionThree.self, forCellWithReuseIdentifier: RestaurantInfoCollectionViewCellSectionThree.identifier)
        collectionView.register(RestaurantInfoCollectionViewCellSectionFour.self, forCellWithReuseIdentifier: RestaurantInfoCollectionViewCellSectionFour.identifier)
        collectionView.register(RestaurantInfoCollectionViewCellSectionFive.self, forCellWithReuseIdentifier: RestaurantInfoCollectionViewCellSectionFive.identifier)
        collectionView.register(RestaurantInfoCollectionViewCellSectionSix.self, forCellWithReuseIdentifier: RestaurantInfoCollectionViewCellSectionSix.identifier)
        // header
        collectionView.register(RestaurantInfoCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RestaurantInfoCollectionReusableView.identifier)
        collectionView.register(RestaurantInfoSectionOneCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RestaurantInfoSectionOneCollectionReusableView.idnetifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.bounces = false
        return collectionView
    }()
    
    private var resVendor: RecommendStructVendors
    private var resInfo: RestaurantInfoStrcut?
    private var discount: Discount = .none
    private var lastIndexActive: IndexPath?
    
    init(resVendor: RecommendStructVendors) {
        self.resVendor = resVendor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(resVendor.id)
        navBarButton()
        setupApi()
        setupLayout()
    }
    
    private func setupApi() {
        CatchAPI.shared.catchResInfo(resID: resVendor.id) { [weak self] data in
            DispatchQueue.main.async {
                switch data.data.discounts {
                case []:
                    self?.discount = .False
                    self?.lastIndexActive = [2, 0]
                default:
                    self?.discount = .True
                    self?.lastIndexActive = [3, 0]
                }
                self?.resInfo = data
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func setupLayout() {
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
}

extension RestaurantInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch discount {
        case .True:
            return 5 + (resInfo?.data.menus[0].menu_categories.count ?? 0)
        case .False:
            return 4 + (resInfo?.data.menus[0].menu_categories.count ?? 0)
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = resInfo?.data.menus[0]
        switch discount {
        case .True:
            for x in 5..<5 + (model?.menu_categories.count ?? 0) {
                if section == x {
                    return model?.menu_categories[x-5].products.count ?? 0
                }
            }
            switch section {
            case 0:
                return 1
            case 1:
                return 1
            case 2:
                return 1
            case 3:
                return model?.menu_categories.count ?? 0
            case 4:
                return model?.tags?.popular.metadata?.sorting?.count ?? 0
            default:
                return 0
            }
        case .False:
            for x in 4..<4 + (model?.menu_categories.count ?? 0) {
                if section == x {
                    return model?.menu_categories[x-4].products.count ?? 0
                }
            }
            switch section {
            case 0:
                return 1
            case 1:
                return 1
            case 2:
                return resInfo?.data.menus[0].menu_categories.count ?? 0
            case 3:
                return resInfo?.data.menus[0].tags?.popular.metadata?.sorting?.count ?? 0
            default:
                return 0
            }
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        switch discount {
        case .True:
            switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionOne.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionOne else {
                    return UICollectionViewCell()
                }
                let resNameLabel = resVendor.name
                let resMessageLabel = "0.3km away | $ 99 最低消費"
                let resEvaluation = "1000 + 評論"
                cell.configure(resNameLabel: resNameLabel, resMessageLabel: resMessageLabel, resEvaluation: resEvaluation)
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionTwo.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionTwo else {
                    return UICollectionViewCell()
                }
                let timeLabel = "外送 \(Int(resVendor.minimum_delivery_time)) 分鐘"
                cell.configure(timeLabel: timeLabel)
                return cell
            case 2:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionThree.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionThree else {
                    return UICollectionViewCell()
                }
                let name = resInfo?.data.discounts[0].name ?? ""
                let description = resInfo?.data.discounts[0].description ?? ""
                cell.configure(name: name, description: description)
                return cell
            case 3:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionFour.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionFour else {
                    return UICollectionViewCell()
                }
                cell.indexPath = indexPath
                let foodTypeLabel = resInfo?.data.menus[0].menu_categories[indexPath.row].name ?? ""
                cell.configure(foodTypeLabel: foodTypeLabel)
                cell.indexPath = indexPath
                return cell
            case 4:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionFive.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionFive else {
                    return UICollectionViewCell()
                }
                let data = setupSectionFiveData(indexPath: indexPath)
                DispatchQueue.main.async {
                    cell.configure(foodNameString: data.name, foodImageUrl: data.images == [] ? "" : data.images![0].image_url, foodPriceDouble: data.product_variations[0].price ?? 0)
                }
                return cell
            case 5..<5 + (resInfo?.data.menus[0].menu_categories.count ?? 0):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionSix.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionSix else {
                    return UICollectionViewCell()
                }
                let model = resInfo?.data.menus[0].menu_categories[indexPath.section - 5].products[indexPath.row]
                let foodTitle = model?.name ?? ""
                let foodDescription = model?.description ?? ""
                let foodPrice = Int(model?.product_variations[0].price ?? 0.0)
                if model?.images == [] {
                    cell.configure(foodTitle: foodTitle, foodDescription: foodDescription, foodPrice: foodPrice, foodImageUrl: "")
                }
                else {
                    let foodImageUrl = model?.images?[0].image_url ?? ""
                    cell.configure(foodTitle: foodTitle, foodDescription: foodDescription, foodPrice: foodPrice, foodImageUrl: foodImageUrl)
                }
                return cell
            default:
                break
            }
        case .False:
            switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionOne.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionOne else {
                    return UICollectionViewCell()
                }
                let resNameLabel = resVendor.name
                let resMessageLabel = "0.3km away | $ 99 最低消費"
                let resEvaluation = "1000 + 評論"
                cell.configure(resNameLabel: resNameLabel, resMessageLabel: resMessageLabel, resEvaluation: resEvaluation)
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionTwo.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionTwo else {
                    return UICollectionViewCell()
                }
                let timeLabel = "外送 \(Int(resVendor.minimum_delivery_time)) 分鐘"
                cell.configure(timeLabel: timeLabel)
                return cell
            case 2:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionFour.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionFour else {
                    return UICollectionViewCell()
                }
                cell.indexPath = indexPath
                let foodTypeLabel = resInfo?.data.menus[0].menu_categories[indexPath.row].name ?? ""
                cell.configure(foodTypeLabel: foodTypeLabel)
                cell.indexPath = indexPath
                return cell
            case 3:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionFive.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionFive else {
                    return UICollectionViewCell()
                }
                let data = setupSectionFiveData(indexPath: indexPath)
                DispatchQueue.main.async {
                    cell.configure(foodNameString: data.name, foodImageUrl: data.images == [] ? "" : data.images![0].image_url, foodPriceDouble: data.product_variations[0].price ?? 0)
                }
                return cell
            case 4..<4 + (resInfo?.data.menus[0].menu_categories.count ?? 0):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantInfoCollectionViewCellSectionSix.identifier, for: indexPath) as? RestaurantInfoCollectionViewCellSectionSix else {
                    return UICollectionViewCell()
                }
                let model = resInfo?.data.menus[0].menu_categories[indexPath.section - 4].products[indexPath.row]
                let foodTitle = model?.name ?? ""
                let foodDescription = model?.description ?? ""
                let foodPrice = Int(model?.product_variations[0].price ?? 0.0)
                if model?.images == [] {
                    cell.configure(foodTitle: foodTitle, foodDescription: foodDescription, foodPrice: foodPrice, foodImageUrl: "")
                }
                else {
                    let foodImageUrl = model?.images?[0].image_url ?? ""
                    cell.configure(foodTitle: foodTitle, foodDescription: foodDescription, foodPrice: foodPrice, foodImageUrl: foodImageUrl)
                }
                return cell
            default:
                break
            }
        case .none:
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch discount {
        case .True:
            for x in 5..<5 + (resInfo?.data.menus[0].menu_categories.count ?? 0) {
                if indexPath.section == x {
                    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RestaurantInfoCollectionReusableView.identifier, for: indexPath) as? RestaurantInfoCollectionReusableView else {
                        return UICollectionReusableView()
                    }
                    header.sectionLabel.text = resInfo?.data.menus[0].menu_categories[indexPath.section - 5].name
                    return header
                }
            }
        case .False:
            for x in 4..<4 + (resInfo?.data.menus[0].menu_categories.count ?? 0) {
                if indexPath.section == x {
                    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RestaurantInfoCollectionReusableView.identifier, for: indexPath) as? RestaurantInfoCollectionReusableView else {
                        return UICollectionReusableView()
                    }
                    header.sectionLabel.text = resInfo?.data.menus[0].menu_categories[indexPath.section - 4].name
                    return header
                }
            }
        case .none:
            break
        }
        switch indexPath.section {
        case 0:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RestaurantInfoSectionOneCollectionReusableView.idnetifier, for: indexPath) as? RestaurantInfoSectionOneCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            DispatchQueue.main.async {
                Nuke.loadImage(with: self.resVendor.hero_image, into: header.imageView)
            }
            
            return header
        default:
            break
        }
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch discount {
        case .True:
            switch indexPath.section {
            case 3:
                if self.lastIndexActive != indexPath {
                    let cell = collectionView.cellForItem(at: indexPath) as? RestaurantInfoCollectionViewCellSectionFour
                    cell?.lineLabel.isHidden = false
                    
                    let cell1 = collectionView.cellForItem(at: lastIndexActive ?? [3, 0]) as? RestaurantInfoCollectionViewCellSectionFour
                    cell1?.lineLabel.isHidden = true
                    self.lastIndexActive = indexPath
                }
                let indexPath = IndexPath(item: 0, section: indexPath.row + 5)
                collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            case 4:
                let orderInfo = setupSectionFiveData(indexPath: indexPath)
                guard orderInfo.product_variations.count <= 1 else {
                    fullOrderViewController(orderInfo: orderInfo)
                    return
                }
                sheetOrderViewController(orderInfo: orderInfo)
            case 5..<5 + (resInfo?.data.menus[0].menu_categories.count ?? 0):
                guard let orderInfo = resInfo?.data.menus[0].menu_categories[indexPath.section - 5].products[indexPath.row] else {
                    return
                }
                guard orderInfo.product_variations.count <= 1 else {
                    fullOrderViewController(orderInfo: orderInfo)
                    return
                }
                sheetOrderViewController(orderInfo: orderInfo)
            default:
                break
            }
        case .False:
            switch indexPath.section {
            case 2:
                if self.lastIndexActive != indexPath {
                    let cell = collectionView.cellForItem(at: indexPath) as? RestaurantInfoCollectionViewCellSectionFour
                    cell?.lineLabel.isHidden = false
                    
                    let cell1 = collectionView.cellForItem(at: lastIndexActive ?? [2, 0]) as? RestaurantInfoCollectionViewCellSectionFour
                    cell1?.lineLabel.isHidden = true
                    self.lastIndexActive = indexPath
                }
                let indexPath = IndexPath(item: 0, section: indexPath.row + 4)
                collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            case 3:
                let orderInfo = setupSectionFiveData(indexPath: indexPath)
                guard orderInfo.product_variations.count <= 1 else {
                    fullOrderViewController(orderInfo: orderInfo)
                    return
                }
                sheetOrderViewController(orderInfo: orderInfo)
            case 4..<4 + (resInfo?.data.menus[0].menu_categories.count ?? 0):
                guard let orderInfo = resInfo?.data.menus[0].menu_categories[indexPath.section - 4].products[indexPath.row] else {
                    return
                }
                guard orderInfo.product_variations.count <= 1 else {
                    fullOrderViewController(orderInfo: orderInfo)
                    return
                }
                sheetOrderViewController(orderInfo: orderInfo)
            default:
                break
            }
        case .none:
            break
        }
    }
    
    private func fullOrderViewController(orderInfo: RestaurantInfoStrcutProducts) {
        let vc = OrderFoodViewController(orderInfo: orderInfo, fullScreen: true, resName: resVendor.name)
        let navvc = UINavigationController(rootViewController: vc)
        navvc.modalPresentationStyle = .fullScreen
        present(navvc, animated: true)
    }
    
    private func sheetOrderViewController(orderInfo: RestaurantInfoStrcutProducts) {
        let vc = OrderFoodViewController(orderInfo: orderInfo, fullScreen: false, resName: resVendor.name)
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            present(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 100.0 {
            resInfoPageSetupNavBarStyleScroll()
            navBarButtonScroll(title: "外送", deliveryTime: "20 分鐘")
        }
        else {
            resInfoPageSetupNavBarStyleTransparent()
            navBarButton()
        }
    }
}

extension RestaurantInfoViewController {
    
    private func navBarButton() {
        let width: CGFloat = 35
        let backButton = UIButton().leftNavBarStyle(tintColor: .white, selectColor: #colorLiteral(red: 0.3060220778, green: 0.03438479081, blue: 0.145960331, alpha: 1), selectedColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1), systemImageName: "chevron.backward.circle.fill", width: width, height: width)
        let addTeamsButton = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: width)).normal(system: "person.crop.circle.fill.badge.plus", size: 20, tintColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1))
        let shareButton = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: width)).normal(system: "square.and.arrow.up", size: 20, tintColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1))
        [addTeamsButton, shareButton].forEach({$0.backgroundColor = .white})
        [addTeamsButton, shareButton].forEach({$0.layer.cornerRadius = width / 2})
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        addTeamsButton.addTarget(self, action: #selector(didTapAddTeamsButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: backButton)
        ]
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: addTeamsButton),
            UIBarButtonItem(customView: shareButton)
        ]
    }
    
    private func navBarButtonScroll(title: String, deliveryTime: String) {
        let width: CGFloat = 35
        let titleView = UILabel()
        titleView.sizeToFit()
        titleView.numberOfLines = 2
        let addressTitleCount = title.count
        let addressTitle = NSMutableAttributedString(string: title + "\n")
        addressTitle.addAttributes([.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 16, weight: .bold)], range: NSMakeRange(0, addressTitleCount))
        let addressTitleCount2 = deliveryTime.count
        let addressTitle2 = NSMutableAttributedString(string: deliveryTime)
        addressTitle2.addAttributes([.foregroundColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1), .font: UIFont.systemFont(ofSize: 14, weight: .regular)], range: NSMakeRange(0, addressTitleCount2))
        addressTitle.append(addressTitle2)
        
        titleView.attributedText = addressTitle
        
        let backButton = UIButton().leftNavBarStyle(tintColor: .white, selectColor: #colorLiteral(red: 0.3060220778, green: 0.03438479081, blue: 0.145960331, alpha: 1), selectedColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1), systemImageName: "chevron.backward.circle.fill", width: width, height: width)
        let addTeamsButton = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: width)).normal(system: "person.crop.circle.fill.badge.plus", size: 20, tintColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1))
        let shareButton = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: width)).normal(system: "square.and.arrow.up", size: 20, tintColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1))
        [addTeamsButton, shareButton].forEach({$0.backgroundColor = .white})
        [addTeamsButton, shareButton].forEach({$0.layer.cornerRadius = width / 2})
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        addTeamsButton.addTarget(self, action: #selector(didTapAddTeamsButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: backButton),
            UIBarButtonItem(customView: titleView)
        ]
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: addTeamsButton),
            UIBarButtonItem(customView: shareButton)
        ]
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapAddTeamsButton() {
        
    }
    
    @objc private func didTapShare() {
        
    }
    
    func resInfoPageSetupNavBarStyleTransparent() {
        let appearance1 = UINavigationBarAppearance()
        appearance1.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance1
        navigationController?.navigationBar.scrollEdgeAppearance = appearance1
    }
    
    func resInfoPageSetupNavBarStyleScroll() {
        let appearance1 = UINavigationBarAppearance()
        appearance1.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance1
        navigationController?.navigationBar.scrollEdgeAppearance = appearance1
    }
}

extension RestaurantInfoViewController {
    
    func setupSectionFiveData(indexPath: IndexPath) -> RestaurantInfoStrcutProducts {
        var name = ""
        var imageUrl = ""
        var describe = ""
        var file_path = ""
        var logo_path = ""
        var price = 0.0
        var product_variations = [RestaurantInfoStrcutVariations]()
        var images: [RestaurantInfoStrcutImages]?
        let sorting = resInfo?.data.menus[0].tags?.popular.metadata?.sorting
        let model = resInfo?.data.menus[0].menu_categories
        let id = sorting?[indexPath.row]
            model?.forEach({ cate in
                cate.products.forEach { pro in
                    if pro.id == id {
                        name = pro.name
                        file_path = pro.file_path
                        logo_path = pro.logo_path
                        describe = pro.description
                        product_variations = pro.product_variations
                        images = pro.images
                        price = pro.product_variations[0].price ?? 0.0
                        guard pro.images == [] else {
                            imageUrl = pro.images?[0].image_url ?? ""
                            return
                        }
                        imageUrl = ""
                    }
                }
            })
        return RestaurantInfoStrcutProducts(id: id ?? 0, name: name, description: describe, file_path: file_path, logo_path: logo_path, product_variations: product_variations, images: images)
    }
}
