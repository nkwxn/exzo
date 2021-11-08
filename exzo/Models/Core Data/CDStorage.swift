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
    
    var journalItems = CurrentValueSubject<[Journal], Never>([])
    private var journalFetchController: NSFetchedResultsController<Journal>
    
    static let shared = CDStorage()
    var context = PersistenceController.shared.container.viewContext
    
    private override init() {
        let productSort = NSSortDescriptor(keyPath: \Product.idProduct, ascending: true)
        let productFetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        productFetchRequest.sortDescriptors = [productSort]
        productFetchController = NSFetchedResultsController(fetchRequest: productFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        let journalSort = NSSortDescriptor(keyPath: \Journal.idJournal, ascending: true)
        let journalFetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest()
        journalFetchRequest.sortDescriptors = [journalSort]
        journalFetchController = NSFetchedResultsController(fetchRequest: journalFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        productFetchController.delegate = self
        journalFetchController.delegate = self
        
        do {
            try productFetchController.performFetch()
            productItems.value = productFetchController.fetchedObjects ?? []
            
            try journalFetchController.performFetch()
            journalItems.value = journalFetchController.fetchedObjects ?? []
        } catch {
            NSLog("Error: could not fetch")
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

// MARK: - CRUD Journal
extension CDStorage {
    func createJournal(foodIntake: String) {
        let newJournal = Journal(context: PersistenceController.shared.container.viewContext)
        newJournal.idJournal = UUID()
        newJournal.foodIntake = foodIntake as NSObject
        
        save()
    }
    
    func updateJournal(with id: UUID) {
        
    }
    
    func deleteJournal(with id: UUID) {
        let journalItem = journalItems.value.filter { item in
            item.idJournal == id
        }
        context.delete(journalItem[0])
    }
}

// MARK: - NSFetchedResultController delegate method
extension CDStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let productItems = controller.fetchedObjects as? [Product] else { return }
        self.productItems.value = productItems
    }
}
