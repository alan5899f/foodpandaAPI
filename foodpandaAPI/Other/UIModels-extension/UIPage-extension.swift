//
//  UIPage-extansion.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/13.
//

import UIKit

extension UIViewController {
    
    func resInfoPageSetupNavBarStyle(navigationController: UINavigationController?, completion: @escaping (Bool) -> Void) {
        let appearance1 = UINavigationBarAppearance()
        appearance1.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance1
        navigationController?.navigationBar.scrollEdgeAppearance = appearance1
        completion(true)
    }
}

