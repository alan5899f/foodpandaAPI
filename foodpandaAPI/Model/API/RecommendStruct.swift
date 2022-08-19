//
//  CategoryStruct.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/7.
//

import Foundation

struct RecommendStruct: Codable {
    let data: RecommendStructData
}

struct RecommendStructData: Codable {
    let items: [RecommendStructItems]
}

struct RecommendStructItems: Codable {
    let ranking: Int
    let headline: String
    let template: String
    let filters: [RecommendStructFilters?]
    let vendors: [RecommendStructVendors?]
}

struct RecommendStructFilters: Codable {
    let id: String
    let title: String
}

struct RecommendStructVendors: Codable, Equatable {
    let id: Int
    let address: String
    let hero_image: String
    let hero_listing_image: String
    let minimum_delivery_fee: Double
    let minimum_delivery_time: Double
    let minimum_pickup_time: Double
    let food_characteristics: [RecommendStructCuisines?]
    let tag: String
    let name: String
    let budget: Int
    let cuisines: [RecommendStructCuisines]
}

struct RecommendStructCuisines: Codable, Equatable {
    let id: Int
    let name: String
}

struct RecommendStructTitle: Equatable {
    let title: String
    let vendors: [RecommendStructVendors?]
}
