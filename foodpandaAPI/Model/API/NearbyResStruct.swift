//
//  NearbyResStruct.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/6.
//

import UIKit

struct NearbyResStruct: Codable {
    let data: NearbyResStructData
}

struct NearbyResStructData: Codable {
    let items: [RecommendStructVendors]
}

struct NearbyResStructItems: Codable {
    let id: Int
    let address: String
    let hero_image: String
    let hero_listing_image: String
    let name: String
    let budget: Int
    let minimum_pickup_time: Double
    let minimum_delivery_time: Double
    let minimum_delivery_fee: Double
    let cuisines: [NearbyResStructCuisines]
    let food_characteristics: [Characteristics?]
}

struct NearbyResStructCuisines: Codable {
    let id: Int
    let name: String
}

struct Characteristics: Codable, Equatable {
    let id: Int
    let name: String
}
