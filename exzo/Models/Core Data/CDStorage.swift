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
    
    // Tambahan dr Nic buat list of food intake, exposure dan activities
    var foodIntakes = CurrentValueSubject<[FoodIntake], Never>([])
    private var intakeFetchController: NSFetchedResultsController<FoodIntake>
    
    var envExposures = CurrentValueSubject<[Exposure], Never>([])
    private var exposureFetchController: NSFetchedResultsController<Exposure>
    
    var activities = CurrentValueSubject<[Activity], Never>([])
    private var activityFetchController: NSFetchedResultsController<Activity>
    
    // ---- End of Tambahannya Nic ---- //
    
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
        
        let ieaSort = NSSortDescriptor(key: "isFavorite", ascending: true)
        
        let intakeFetchRequest = FoodIntake.fetchRequest()
        intakeFetchRequest.sortDescriptors = [ieaSort]
        intakeFetchController = NSFetchedResultsController(fetchRequest: intakeFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        let exposureFetchRequest = Exposure.fetchRequest()
        exposureFetchRequest.sortDescriptors = [ieaSort]
        exposureFetchController = NSFetchedResultsController(fetchRequest: exposureFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        let activityFetchRequest = Activity.fetchRequest()
        activityFetchRequest.sortDescriptors = [ieaSort]
        activityFetchController = NSFetchedResultsController(fetchRequest: activityFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        productFetchController.delegate = self
        journalFetchController.delegate = self
        intakeFetchController.delegate = self
        exposureFetchController.delegate = self
        activityFetchController.delegate = self
        
        do {
            try productFetchController.performFetch()
            productItems.value = productFetchController.fetchedObjects ?? []
            
            try journalFetchController.performFetch()
            journalItems.value = journalFetchController.fetchedObjects ?? []
            
            try intakeFetchController.performFetch()
            foodIntakes.value = intakeFetchController.fetchedObjects ?? []
            
            try exposureFetchController.performFetch()
            envExposures.value = exposureFetchController.fetchedObjects ?? []
            
            try activityFetchController.performFetch()
            activities.value = activityFetchController.fetchedObjects ?? []
        } catch {
            NSLog("Error: could not fetch")
        }
        
        // Append template IEA
        createIEATemplate()
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
    
    func createJournal(foodIntake: [FoodIntakes]) {
        
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

// MARK: - Buat Intake, Exposure dan Activity
struct IEAData: Identifiable {
    let id = UUID()
    var name: String
    var thumb: String
}

struct RawIEAData {
    static let foodIntakeTemplate = [
        IEAData(name: "Gluten", thumb: "Icon004"),
        IEAData(name: "Seafood", thumb: "Icon003"),
        IEAData(name: "Poultry", thumb: "Icon002"),
        IEAData(name: "Egg", thumb: "Icon005"),
        IEAData(name: "Nut", thumb: "Icon006"),
        IEAData(name: "Dairy", thumb: "Icon001"),
        IEAData(name: "Grain", thumb: "Icon007")
    ]
    static let exposureTemplate = [
        IEAData(name: "Pollen", thumb: "Icon008"),
        IEAData(name: "Dust", thumb: "Icon010"),
        IEAData(name: "Sun", thumb: "Icon018"),
        IEAData(name: "Moulds", thumb: "Icon011")
    ]
    static let activityTemplate = [
        IEAData(name: "Exercise", thumb: "Icon013"),
        IEAData(name: "Work", thumb: "Icon014"),
        IEAData(name: "Jogging", thumb: "Icon015"),
        IEAData(name: "Running", thumb: "Icon017"),
        IEAData(name: "Washing Dishes", thumb: "Icon012"),
        IEAData(name: "Yoga", thumb: "Icon008"),
        IEAData(name: "Cooking", thumb: "Icon016")
    ]
}

// MARK: - CRUD Exposure, Food Intake, dan Activity Template
extension CDStorage {
    func createIEATemplate() {
        // Add to Core Data Stack
        if foodIntakes.value.isEmpty {
            for rawIntake in RawIEAData.foodIntakeTemplate {
                let newIntake = FoodIntake(context: self.context)
                newIntake.idFoodIntake = rawIntake.id
                newIntake.intakeName = rawIntake.name
                newIntake.intakeThumb = rawIntake.thumb
                newIntake.isFavorite = true
                newIntake.deletable = false
                save()
            }
            save()
        }
        
        if envExposures.value.isEmpty {
            for rawExposure in RawIEAData.exposureTemplate {
                let newExposure = Exposure(context: self.context)
                newExposure.idExposure = rawExposure.id
                newExposure.exposureName = rawExposure.name
                newExposure.exposureThumb = rawExposure.thumb
                newExposure.isFavorite = true
                newExposure.deletable = false
                save()
            }
            save()
        }
        
        if activities.value.isEmpty {
            for rawActivity in RawIEAData.activityTemplate {
                let newActivity = Activity(context: self.context)
                newActivity.idActivity = rawActivity.id
                newActivity.activityName = rawActivity.name
                newActivity.activityThumb = rawActivity.thumb
                newActivity.isFavorite = true
                newActivity.deletable = false
                save()
            }
            save()
        }
    }
    
    enum IEA: String {
        case activity = "Activity"
        case exposure = "Exposure"
        case intake = "Intake"
    }
    
    func createIEA(_ type: IEA, name: String, thumb: String) {
        switch type {
        case .activity:
            let activity = Activity(context: self.context)
            activity.activityName = name
            activity.activityThumb = thumb
            activity.deletable = true
            activity.isFavorite = false
        case .exposure:
            let exposure = Exposure(context: self.context)
            exposure.exposureName = name
            exposure.exposureThumb = thumb
            exposure.deletable = true
            exposure.isFavorite = false
        case .intake:
            let intake = FoodIntake(context: self.context)
            intake.intakeName = name
            intake.intakeThumb = thumb
            intake.deletable = true
            intake.isFavorite = false
        }
        save()
    }
    
    func deleteIEA(_ type: IEA, id: UUID) {
        switch type {
        case .activity:
            context.delete(activities.value.filter { item in
                item.idActivity == id
            }[0])
        case .exposure:
            context.delete(envExposures.value.filter { item in
                item.idExposure == id
            }[0])
        case .intake:
            context.delete(activities.value.filter { item in
                item.idActivity == id
            }[0])
        }
    }
    
    // Bulk delete all IEA
    func deleteAllIEA() {
        let activity = activities.value
        let exposure = envExposures.value
        let intake = foodIntakes.value
        for activity in activity {
            context.delete(activity)
        }
        for exposure in exposure {
            context.delete(exposure)
        }
        for intake in intake {
            context.delete(intake)
        }
        save()
    }
}

// MARK: - NSFetchedResultController delegate method
extension CDStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let productItems = controller.fetchedObjects as? [Product] {
            self.productItems.value = productItems
        } else if let journalItems = controller.fetchedObjects as? [Journal] {
            self.journalItems.value = journalItems
        } else if let activityItems = controller.fetchedObjects as? [Activity] {
            self.activities.value = activityItems
        } else if let exposureItems = controller.fetchedObjects as? [Exposure] {
            self.envExposures.value = exposureItems
        } else if let intakeItems = controller.fetchedObjects as? [FoodIntake] {
            self.foodIntakes.value = intakeItems
        }
    }
}
