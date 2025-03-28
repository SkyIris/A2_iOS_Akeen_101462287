//
//  ProductsProvider.swift
//  A2_iOS_Akeen_101462287
//
//  Created by Akeen on 2025-03-28.
//
import CoreData
import Foundation

final class ProductsProvider {
    static let shared = ProductsProvider()
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext{
        persistentContainer.viewContext
    }
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "ProductsDataModel")
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores{_, error in
            if let error{
                fatalError("unable to load core data: \(error)")
            }}
    }
}
