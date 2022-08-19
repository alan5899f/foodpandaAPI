//
//  RestaurantInfoStrcut.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/13.
//

import Foundation

struct RestaurantInfoStrcut: Codable {
    let status_code: Int
    let data: RestaurantInfoStrcutData
}

struct RestaurantInfoStrcutData: Codable {
    let id: Int
    let address: String
    let customer_phone: String
    let description: String
    let hero_image: String
    let is_busy: Bool
    let name: String
    let budget: Int
    let tag: String
    let minimum_delivery_fee: Double
    let minimum_delivery_time: Double
    let minimum_pickup_time: Double
    let menus: [RestaurantInfoStrcutMenus]
    let discounts: [RestaurantInfoStrcutDiscounts]
}

struct RestaurantInfoStrcutDiscounts: Codable, Equatable {
    let id: Int
    let name: String
    let description: String
}

struct RestaurantInfoStrcutMenus: Codable {
    let id: Int
    let name: String
    let type: String
    let menu_categories: [RestaurantInfoStrcutCategories]
    let tags: RestaurantInfoStrcutPopular?
}

struct RestaurantInfoStrcutPopular: Codable {
    let popular: RestaurantInfoStrcutPopularInfo
}

struct RestaurantInfoStrcutPopularInfo: Codable {
    let name: String
    let metadata: RestaurantInfoStrcutMetadata?
}

struct RestaurantInfoStrcutMetadata: Codable {
    let sorting: [Int]?
}

struct RestaurantInfoStrcutCategories: Codable {
    let id: Int
    let name: String
    let description: String
    let products: [RestaurantInfoStrcutProducts]
}

struct RestaurantInfoStrcutProducts: Codable {
    let id: Int
    let name: String
    let description: String
    let file_path: String
    let logo_path: String
//    let tags: [String]?
    let product_variations: [RestaurantInfoStrcutVariations]
    let images: [RestaurantInfoStrcutImages]?
}

struct RestaurantInfoStrcutImages: Codable, Equatable {
    let image_url: String
}


struct RestaurantInfoStrcutVariations: Codable {
    let id: Int
    let price: Double?
    let price_before_discount: Int?
    let name: String?
}
