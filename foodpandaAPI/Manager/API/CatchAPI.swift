//
//  CatchAPI.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/6.
//

import UIKit

class CatchAPI {
    
    static let shared = CatchAPI()
    
    public func catchNearbyRes(limit: Int, longitude: CGFloat, latitude: CGFloat, completion: @escaping (NearbyResStruct) -> Void) {
        
        let url = URL(string: APIURL.nearbyRes + "longitude=\(longitude)&latitude=\(latitude)&limit=\(limit)")
        var request = URLRequest(url: url!)
        request.addValue("web", forHTTPHeaderField: "x-disco-client-id")
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(json)
                let result = try JSONDecoder().decode(NearbyResStruct.self, from: data)
                completion(result)
            }
            catch {
                print("catchError")
            }
        }.resume()
    }
    
    public func catchCategory(completion: @escaping (CategoryStruct) -> Void) {
        let path = Bundle.main.path(forResource: "CategoryJSON", ofType: "json")
        let url = URL(fileURLWithPath: path!)

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(json)
                let result = try JSONDecoder().decode(CategoryStruct.self, from: data)
                completion(result)
            }
            catch {
                print("catchError1")
            }
        }.resume()
    }
    
    public func catchRecommendRes(limit: Int, longitude: CGFloat, latitude: CGFloat, completion: @escaping (RecommendStruct) -> Void) {
        
        let url = URL(string: APIURL.recommendRes + "longitude=\(longitude)&latitude=\(latitude)&limit=\(limit)")
        var request = URLRequest(url: url!)
        request.addValue("web", forHTTPHeaderField: "x-disco-client-id")
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(json)
                let result = try JSONDecoder().decode(RecommendStruct.self, from: data)
                completion(result)
            }
            catch {
                print("catchError")
            }
        }.resume()
    }
    
    func catchResInfo(resID: Int, completion: @escaping (RestaurantInfoStrcut) -> Void) {
        let url = URL(string: APIURL.resInfoAndMeun + "\(resID)?include=menus")
        var request = URLRequest(url: url!)
        request.setValue("web", forHTTPHeaderField: "x-disco-client-id")
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(json)
                let result = try JSONDecoder().decode(RestaurantInfoStrcut.self, from: data)
                completion(result)
            }
            catch {
                print("catchResInfoError")
            }
        }.resume()
    }
}
