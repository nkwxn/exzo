//
//  CDStorage.swift
//  Atemis
//
//  Created by Daniella Stefani on 02/11/21.
//

import SwiftUI
import CoreData
import Combine

class CDStorage: NSObject, ObservableObject {
    var productItems = CurrentValueSubject<[Product], Never>([])
    private var productFetchController: NSFetchedResultsController<Product>
    
    static let shared = CDStorage()
    var context = PersistenceController.shared.container.viewContext
    
    private override init() {
        let productSort = NSSortDescriptor(keyPath: \Product.idProduct, ascending: true)
        let productFetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        productFetchRequest.sortDescriptors = [productSort]
        productFetchController = NSFetchedResultsController(fetchRequest: productFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        productFetchController.delegate = self
        
        do {
            try productFetchController.performFetch()
            productItems.value = productFetchController.fetchedObjects ?? []
        } catch {
            NSLog("Error: could not fetch Product")
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
    }
}

// MARK: - CRUD Product
extension CDStorage {
    func createProduct(name: String, type: ProductType, image: UIImage? = nil) {
        let newProduct = Product(context: PersistenceController.shared.container.viewContext)
        newProduct.idProduct = UUID()
        newProduct.productName = name
        newProduct.productType = type.rawValue
        newProduct.productImage = (image ?? UIImage()) as NSObject
        
        save()
    }
    
    func updateProduct(with id: UUID) {
        
    }
    
    func deleteProduct(with id: UUID) {
        let productItem = productItems.value.filter { item in
            item.idProduct == id
        }
        context.delete(productItem[0])
    }
}

// MARK: - NSFetchedResultController delegate method
extension CDStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let productItems = controller.fetchedObjects as? [Product] else { return }
        self.productItems.value = productItems
    }
}
