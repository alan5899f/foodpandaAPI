//
//  GoogleMapViewController.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/8.
//

import UIKit
import MapKit
import CoreLocation
import PKHUD
import SwiftUI

protocol MapViewControllerDelegate: AnyObject {
    func didBackUpdate()
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    private let map = MKMapView()
    private let pin = UIImageView().customModel(contentMode: .scaleAspectFit)
    private let mapAddressView = MapAddressView()
    
    let manager = CLLocationManager()
    let geocoderUS = CLGeocoder()
    let geocoderTW = CLGeocoder()
    
    var setLongitude: Double
    var setLatitude: Double
    
    weak var delegate: MapViewControllerDelegate?
    
    init(setLongitude: Double, setLatitude: Double) {
        self.setLatitude = setLatitude
        self.setLongitude = setLongitude
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupLayout()
        HUD.show(.progress, onView: view)
    }
    
    private func setupNavBar() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        let backButton = UIButton().leftNavBarStyle(tintColor: .white, selectColor: #colorLiteral(red: 0.3060220778, green: 0.03438479081, blue: 0.145960331, alpha: 1), selectedColor: #colorLiteral(red: 0.7956677079, green: 0.03153911978, blue: 0.3766415119, alpha: 1), systemImageName: "xmark.circle.fill", width: 30, height: 30)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupLayout() {
        pin.image = UIImage(named: "地標")
        mapAddressView.layer.cornerRadius = 20
        mapAddressView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(map)
        view.addSubview(pin)
        view.addSubview(mapAddressView)
        
        map.frame = view.bounds
        pin.frame.size = CGSize(width: 40, height: 40)
        pin.center = CGPoint(x: view.center.x, y: view.center.y - 20)
        map.delegate = self
        mapAddressView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapAddressView.frame = CGRect(x: 0, y: view.bottom - 200, width: view.width, height: 200)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func geocoder(latitude: Double, longitude: Double) {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoderUS.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en-US")) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                guard let placemark = placemarks?.first, error == nil else { return }
                self?.mapAddressView.address2.text = String(placemark.subAdministrativeArea ?? "") + ", " + String(placemark.postalCode ?? "")
                group.leave()
            }
        }
        geocoderTW.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "zh-TW")) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                guard let placemark = placemarks?.first, error == nil else { return }
                self?.mapAddressView.address1.text = String(placemark.subThoroughfare ?? "") + String(placemark.thoroughfare ?? "")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            HUD.hide()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            if setLatitude == 0.0, setLongitude == 0.0 {
                render(location)
            }
            else {
                render(CLLocation(latitude: setLatitude, longitude: setLongitude))
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        self.setLatitude = center.latitude
        self.setLongitude = center.longitude
        geocoder(latitude: center.latitude, longitude: center.longitude)
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        geocoder(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let snap = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        let regino = MKCoordinateRegion(center: coordinate, span: snap)
        
        map.setRegion(regino, animated: false)
    }
    
    @objc private func didTapBack() {
        delegate?.didBackUpdate()
        dismiss(animated: true)
    }
}

extension MapViewController: MapAddressViewDelegate {
    
    func didTapSaveAddress() {
        UserDefaults.standard.setValue(setLatitude, forKey: "latitude")
        UserDefaults.standard.setValue(setLongitude, forKey: "longitude")
        delegate?.didBackUpdate()
        dismiss(animated: true)
    }
}
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard !(annotation is MKUserLocation) else {
//            return nil
//        }
//        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
//
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
//            annotationView?.canShowCallout = true
//        }
//        else {
//            annotationView?.annotation = annotation
//        }
//        annotationView?.image = UIImage(named: "地標")
//
//        return annotationView
//    }
