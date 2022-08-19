//
//  DataPersistenceManager.swift
//  foodpandaAPI
//
//  Created by 陳韋綸 on 2022/8/11.
//

import Foundation
import UIKit
import CoreData

enum DatabaseError: Error {
    case failedToSaveData
    case failedToFetchData
    case failedToDeleteData
}

class DataPersistenceManager {
    
    static let shared = DataPersistenceManager()
    
    let a = 0
    
    func ordered(model: RestaurantInfoStrcutProducts, row: Int, resName: String, foodCount: Int, price: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let ordered = Ordered(context: context)
        
        ordered.name = model.name
        ordered.descriptions = model.description
        ordered.file_path = model.file_path
        ordered.logo_path = model.logo_path
        ordered.price = Int64(price)
        ordered.names = model.product_variations[row].name
        ordered.image_url = model.images == [] ? "" : model.images?[0].image_url
        ordered.resName = resName
        ordered.foodCount = Int64(foodCount)
        
        do {
            try context.save()
            completion(.success(()))
        }
        catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchingOrderFromDatabase(completion: @escaping (Result<[Ordered], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<Ordered>
        
        request = Ordered.fetchRequest()
        
        do {
            let ordered = try context.fetch(request)
            completion(.success(ordered))
        }
        catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteOrderWith(model: Ordered, compltion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            compltion(.success(()))
        }
        catch {
            compltion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
