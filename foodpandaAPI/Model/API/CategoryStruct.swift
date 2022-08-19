//
//  CategoryStruct.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/7/7.
//

import Foundation

struct CategoryStruct: Codable {
    let filters: [CategoryStructFilters]
    let discount: [CategoryStructDiscount]
}

struct CategoryStructFilters: Codable {
    let id: String
    let title: String
    let url: String
}

struct CategoryStructDiscount: Codable {
    let url: String
}
