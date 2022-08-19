//
//  ViewController.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/6.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { index, _  in
            if index == 0 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item])
                let section = NSCollectionLayoutSection(group: Hgroup)
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
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
                let Vgroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1)), subitem: item, count: 2)
                let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitems: [Vgroup])
                let section = NSCollectionLayoutSection(group: Hgroup)
                section.orthogonalScrollingBehavior = .continuous
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            }
            if index == 3 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
                let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: Hgroup)
                section.orthogonalScrollingBehavior = .continuous
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            }
            if index == 4 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item])
                let section = NSCollectionLayoutSection(group: Hgroup)
                return section
            }
            return nil
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCellSectionOne.self, forCellWithReuseIdentifier: HomeCollectionViewCellSectionOne.identifier)
        collectionView.register(HomeCollectionViewCellSectionTwo.self, forCellWithReuseIdentifier: HomeCollectionViewCellSectionTwo.identifier)
        collectionView.register(HomeCollectionViewCellSectionThree.self, forCellWithReuseIdentifier: HomeCollectionViewCellSectionThree.identifier)
        collectionView.register(HomeCollectionViewCellSectionFour.self, forCellWithReuseIdentifier: HomeCollectionViewCellSectionFour.identifier)
        collectionView.register(HomeCollectionViewCellSectionFive.self, forCellWithReuseIdentifier: HomeCollectionViewCellSectionFive.identifier)
        // header
        collectionView.register(HomeCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionReusableView.identifier)
        collectionView.register(HomeCollectionReusableViewDiscount.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionReusableViewDiscount.identifier)
        return collectionView
    }()
    
    
    private let homeMenuView = HomeMenuView()
    private let homeMenuViewBackGround = UIView()
    
    private var nearbyResData: NearbyResStruct? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var categoryData: CategoryStruct? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private let manager = CLLocationManager()
    
    let geocoderUS = CLGeocoder()
    let geocoderTW = CLGeocoder()
    
    var setLongitude: Double = 0.0
    var setLatitude: Double = 0.0
    
    var street: String!
    var city: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupBinding()
        setupAPI()
        homeMenuView.delegate = self
        updateLocation()
        detectLocation(type: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarStyle()
    }
    
    private func detectLocation(type: Int) {
        if setLatitude == 0.0, setLongitude == 0.0 {
            self.street = "請輸入您要外送的地址"
            self.city = "點擊我輸入"
            navBarButton(addressStreet: street, addressCity: city)
        }
        else {
            geocoder(latitude: setLatitude, longitude: setLongitude, type: type)
        }
    }
    
    private func updateLocation() {
        let saveLatitude = UserDefaults.standard.double(forKey: "latitude")
        let saveLongitude = UserDefaults.standard.double(forKey: "longitude")
        
        setLongitude = saveLongitude
        setLatitude = saveLatitude
    }
    
    func geocoder(latitude: Double, longitude: Double, type: Int) {
        let group = DispatchGroup()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        group.enter()
        group.enter()
        geocoderUS.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en-US")) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                guard let placemark = placemarks?.first, error == nil else { return }
                self?.city = String(placemark.subAdministrativeArea ?? "") + ", " + String(placemark.postalCode ?? "")
                group.leave()
            }
        }
        geocoderTW.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "zh-TW")) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                guard let placemark = placemarks?.first, error == nil else { return }
                self?.street = String(placemark.subThoroughfare ?? "") + String(placemark.thoroughfare ?? "")
                group.leave()
            }
        }
        group.notify(queue: .main) {
            if type == 0 {
                self.navBarButton(addressStreet: self.street, addressCity: self.city)
            }
            if type == 1 {
                self.navBarButtonClick(addressStreet: self.street, addressCity: self.city)
            }
        }
    }
    
    private func setupAPI() {
        CatchAPI.shared.catchNearbyRes(limit: 5, longitude: IM暫時的經緯度.經度, latitude: IM暫時的經緯度.緯度) { [weak self] data in
            DispatchQueue.main.async {
                self?.nearbyResData = data
            }
        }
        CatchAPI.shared.catchCategory { [weak self] data in
            DispatchQueue.main.async {
                self?.categoryData = data
            }
        }
    }
    
    private func setupBinding() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBack))
        homeMenuViewBackGround.addGestureRecognizer(tap)
    }
    
    private func setupLayout() {
        homeMenuView.layer.cornerRadius = 10
        homeMenuView.clipsToBounds = true
        homeMenuView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        homeMenuView.isHidden = true
        homeMenuViewBackGround.isHidden = true
        homeMenuViewBackGround.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        manager.delegate = self
        
        view.addSubview(collectionView)
        view.addSubview(homeMenuViewBackGround)
        view.addSubview(homeMenuView)
        collectionView.frame = view.bounds
        homeMenuViewBackGround.frame = view.bounds
        homeMenuView.frame = CGRect(x: 0, y: navigationController?.navigationBar.bottom ?? 0.0, width: view.width, height: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 3 {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionReusableViewDiscount.identifier, for: indexPath) as? HomeCollectionReusableViewDiscount else {
                return UICollectionReusableView()
            }
            
            return header
        }
        else {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionReusableView.identifier, for: indexPath) as? HomeCollectionReusableView else {
                return UICollectionReusableView()
            }
            if indexPath.section == 1 {
                header.sectionLabel.text = "重新下訂"
            }
            if indexPath.section == 2 {
                header.sectionLabel.text = "在家吃遍全世界"
            }
            return header
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return nearbyResData?.data.items.count ?? 0
        }
        if section == 2 {
            return categoryData?.filters.count ?? 0
        }
        if section == 3 {
            return categoryData?.discount.count ?? 0
        }
        if section == 4 {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellSectionOne.identifier, for: indexPath) as? HomeCollectionViewCellSectionOne else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            return cell
        }
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellSectionTwo.identifier, for: indexPath) as? HomeCollectionViewCellSectionTwo else {
                return UICollectionViewCell()
            }
            let model = nearbyResData?.data.items[indexPath.row]
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
        if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellSectionThree.identifier, for: indexPath) as? HomeCollectionViewCellSectionThree else {
                return UICollectionViewCell()
            }
            let title = categoryData?.filters[indexPath.row].title ?? ""
            let imageUrl = categoryData?.filters[indexPath.row].url ?? ""
            cell.configure(title: title, imageUrl: imageUrl)
            return cell
        }
        if indexPath.section == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellSectionFour.identifier, for: indexPath) as? HomeCollectionViewCellSectionFour else {
                return UICollectionViewCell()
            }
            let imageUrl = categoryData?.discount[indexPath.row].url ?? ""
            cell.configure(imageUrl: imageUrl)
            return cell
        }
        if indexPath.section == 4 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellSectionFive.identifier, for: indexPath) as? HomeCollectionViewCellSectionFive else {
                return UICollectionViewCell()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let resVendor = nearbyResData?.data.items[indexPath.row] else {
                return
            }
            resInfoPageSetupNavBarStyle(navigationController: navigationController) { [weak self] done in
                if done {
                    DispatchQueue.main.async {
                        let vc = RestaurantInfoViewController(resVendor: resVendor)
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
}

extension HomeViewController {
    
    private func navBarButton(addressStreet: String, addressCity: String) {
        // NSMutableAttributedString
        let address = UILabel()
        address.sizeToFit()
        address.numberOfLines = 2
        let addressTitleCount = addressStreet.count
        let addressTitle = NSMutableAttributedString(string: addressStreet + "\n")
        addressTitle.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 14, weight: .medium)], range: NSMakeRange(0, addressTitleCount))
        let addressTitleCount2 = addressCity.count
        let addressTitle2 = NSMutableAttributedString(string: addressCity)
        addressTitle2.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 12, weight: .regular)], range: NSMakeRange(0, addressTitleCount2))
        addressTitle.append(addressTitle2)
        
        address.attributedText = addressTitle
        
        address.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAddress))
        address.addGestureRecognizer(tap)
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(didTapOtherInfo)),
            UIBarButtonItem(customView: address)
        ]
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bag"), style: .done, target: self, action: #selector(didTapMyOrderedShop)),
            UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(didTapCollection))
        ]
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItems?.forEach({$0.tintColor = .white})
    }
    
    private func navBarButtonClick(addressStreet: String, addressCity: String) {
        // NSMutableAttributedString
        let address = UILabel()
        address.sizeToFit()
        address.numberOfLines = 2
        let addressTitleCount = addressStreet.count
        let addressTitle = NSMutableAttributedString(string: addressStreet + "\n")
        addressTitle.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 14, weight: .medium)], range: NSMakeRange(0, addressTitleCount))
        let addressTitleCount2 = addressCity.count
        let addressTitle2 = NSMutableAttributedString(string: addressCity)
        addressTitle2.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 12, weight: .regular)], range: NSMakeRange(0, addressTitleCount2))
        addressTitle.append(addressTitle2)
        
        address.attributedText = addressTitle
        
        address.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAddress))
        address.addGestureRecognizer(tap)
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "xmark")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)), style: .done, target: self, action: #selector(didTapBack)),
            UIBarButtonItem(customView: address)
        ]
        navigationItem.rightBarButtonItems?.removeAll()
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc private func didTapBack() {
        UIView.animate(withDuration: 0.3) { [self] in
            homeMenuView.frame = CGRect(x: 0, y: navigationController?.navigationBar.bottom ?? 0.0, width: view.width, height: 0)
        } completion: { [self] done in
            if done {
                homeMenuView.isHidden = true
                homeMenuViewBackGround.isHidden = true
                navBarButton(addressStreet: street, addressCity: city)
            }
        }
    }
    
    @objc private func didTapAddress() {
        UIView.animate(withDuration: 0.1) { [self] in
            homeMenuView.isHidden = false
            homeMenuViewBackGround.isHidden = false
            homeMenuView.frame = CGRect(x: 0, y: navigationController?.navigationBar.bottom ?? 0.0, width: view.width, height: 100)
        } completion: { [self] done in
            if done {
                navBarButtonClick(addressStreet: street, addressCity: city)
            }
        }
    }
    
    @objc private func didTapOtherInfo() {
        
    }
    
    @objc private func didTapCollection() {
        
    }
    
    @objc private func didTapMyOrderedShop() {
        let vc = OrderedViewController()
        let navvc = UINavigationController(rootViewController: vc)
        navvc.modalPresentationStyle = .fullScreen
        present(navvc, animated: true)
    }
    
    private func setupNavBarStyle() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1)
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
}

extension HomeViewController: HomeMenuViewDelegate {
    
    func currentAddress() {
        let alert = UIAlertController(title: "位置", message: "將儲存您的位置", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: { _ in
            self.manager.startUpdatingLocation()
        }))
        present(alert, animated: true)
    }
    
    func newAddress() {
        let vc = MapViewController(setLongitude: setLongitude, setLatitude: setLatitude)
        vc.delegate = self
        let navvc = UINavigationController(rootViewController: vc)
        navvc.modalPresentationStyle = .fullScreen
        present(navvc, animated: true)
    }
}

extension HomeViewController: MapViewControllerDelegate {
    
    func didBackUpdate() {
        updateLocation()
        detectLocation(type: 1)
    }
}

extension HomeViewController: HomeCollectionViewCellSectionOneDelegate {
    
    func didTapFoodDelivery() {
        let vc = FoodDeliveryViewController(street: street, longitude: setLongitude, latitude: setLatitude)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapFresh() {
        
    }
    
    func didTapSuperMarket() {
        
    }
    
    func didTapFoodTakeOut() {
        
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            UserDefaults.standard.setValue(latitude, forKey: "latitude")
            UserDefaults.standard.setValue(longitude, forKey: "longitude")
            self.setLatitude = latitude
            self.setLongitude = longitude
            geocoder(latitude: latitude, longitude: longitude, type: 1)
            manager.stopUpdatingLocation()
        }
    }
}
