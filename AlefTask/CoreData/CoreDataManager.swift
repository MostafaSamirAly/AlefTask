//
//  CoreDataManager.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/2021.
//

import UIKit
import CoreData

private enum CoreDataConstants: String {
    case id
    case image
    case productDescription
    case title
}

class CoreDataHelper {
    static let shared = CoreDataHelper()
    let managedContext : NSManagedObjectContext
    var retrievedData : Array<NSManagedObject> = []
    private init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }else {
            managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        }
        
    }
    
    func getProductsFromCoreData(entityName : String = "ProductEntity") -> [Product] {
        var products = [Product]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        
        do {
            retrievedData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
        if retrievedData.count != 0 {
            products = retrievedData.compactMap {
                Product(id: $0.value(forKey: CoreDataConstants.id.rawValue) as? Int,
                        title: $0.value(forKey: CoreDataConstants.title.rawValue) as? String,
                        productDescription: $0.value(forKey: CoreDataConstants.productDescription.rawValue) as? String,
                        image: $0.value(forKey: CoreDataConstants.image.rawValue) as? String)
            }
        }
        return products
    }
    
    
    
    func insert(products:[Product],into entityName: String = "ProductEntity") -> Void {
        DeleteAllProducts()
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) {
            for product in products {
                let productToInsert = NSManagedObject(entity: entity, insertInto: managedContext)
                productToInsert.setValue(product.id, forKey: CoreDataConstants.id.rawValue)
                productToInsert.setValue(product.images?.first?.imageName, forKey: CoreDataConstants.image.rawValue)
                productToInsert.setValue(product.title, forKey: CoreDataConstants.title.rawValue)
                productToInsert.setValue(product.productDescription, forKey: CoreDataConstants.productDescription.rawValue)
                do{
                    try managedContext.save()
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        
    }
    
    private func DeleteAllProducts(entityName : String = "ProductEntity") -> Void{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result {
                managedContext.delete(object)
            }
            do{
                try managedContext.save()
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func isFavourite(_ product: Product?, entityName: String = "FavouriteEntity") -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        do {
            retrievedData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
            return false
        }
        
        if retrievedData.isEmpty {
            return false
        }else {
            return retrievedData.contains { ($0.value(forKey: CoreDataConstants.id.rawValue) as? Int) == product?.id }
        }
    }
    
    func toggleFavourite(for product: Product?, entityName: String = "FavouriteEntity") {
        if product?.isFavourite ?? false {
            addFavourite(for: product)
        }else {
            removeFavourite(for: product)
        }
    }
    
    private func addFavourite(for product: Product?, entityName: String = "FavouriteEntity") {
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) {
            let productToInsert = NSManagedObject(entity: entity, insertInto: managedContext)
            productToInsert.setValue(product?.id, forKey: CoreDataConstants.id.rawValue)
            do{
                try managedContext.save()
            } catch let error as NSError {
                print(error)
            }
            
        }
    }
    
    private func removeFavourite(for product: Product?, entityName: String = "FavouriteEntity") {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        var favourites: Array<NSManagedObject> = []
        do {
            favourites = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
        
        if favourites.isEmpty {
            return
        }else {
            if let product = favourites.first(where: { ($0.value(forKey: CoreDataConstants.id.rawValue) as? Int) == product?.id }) {
                managedContext.delete(product)
                do{
                    try managedContext.save()
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
}
