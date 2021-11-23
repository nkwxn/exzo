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
    
    var skinCondition = CurrentValueSubject<[SkinCondition], Never>([])
    private var skinConditionFetchController: NSFetchedResultsController<SkinCondition>
    
    var triggerArea = CurrentValueSubject<[TriggerAreas], Never>([])
    private var triggerAreaFetchController: NSFetchedResultsController<TriggerAreas>
    
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
        
        let ieaSort = NSSortDescriptor(key: "isFavorite", ascending: false)
        
        let intakeFetchRequest = FoodIntake.fetchRequest()
        intakeFetchRequest.sortDescriptors = [ieaSort]
        intakeFetchController = NSFetchedResultsController(fetchRequest: intakeFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        let exposureFetchRequest = Exposure.fetchRequest()
        exposureFetchRequest.sortDescriptors = [ieaSort]
        exposureFetchController = NSFetchedResultsController(fetchRequest: exposureFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        let activityFetchRequest = Activity.fetchRequest()
        activityFetchRequest.sortDescriptors = [ieaSort]
        activityFetchController = NSFetchedResultsController(fetchRequest: activityFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        let conditionSort = NSSortDescriptor(keyPath: \SkinCondition.idCondition, ascending: true)
        let conditionFetchRequest = SkinCondition.fetchRequest()
        conditionFetchRequest.sortDescriptors = [conditionSort]
        skinConditionFetchController = NSFetchedResultsController(fetchRequest: conditionFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        let triggerSort = NSSortDescriptor(keyPath: \TriggerAreas.idTrigger, ascending: true)
        let triggerFetchRequest = TriggerAreas.fetchRequest()
        triggerFetchRequest.sortDescriptors = [triggerSort]
        triggerAreaFetchController = NSFetchedResultsController(fetchRequest: triggerFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        productFetchController.delegate = self
        journalFetchController.delegate = self
        intakeFetchController.delegate = self
        exposureFetchController.delegate = self
        activityFetchController.delegate = self
        skinConditionFetchController.delegate = self
        triggerAreaFetchController.delegate = self
        
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
            
            try skinConditionFetchController.performFetch()
            skinCondition.value = skinConditionFetchController.fetchedObjects ?? []
            
            try triggerAreaFetchController.performFetch()
            triggerArea.value = triggerAreaFetchController.fetchedObjects ?? []
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
            print("Error saving: \(error)")
        }
    }
}

// MARK: - CRUD Product
extension CDStorage {
    func createProduct(name: String, type: ProductType, image: UIImage? = nil, ingredients: [String]? = nil) {
        let newProduct = Product(context: PersistenceController.shared.container.viewContext)
        newProduct.idProduct = UUID()
        newProduct.productName = name
        newProduct.productType = type.rawValue
        newProduct.productImage = (image ?? UIImage()) as NSObject
        newProduct.productIngr = ingredients as NSObject?
        save()
    }
    
    func updateProduct(with id: UUID) {
        
    }
    
    func deleteProduct(with id: UUID) {
        let productItem = productItems.value.filter { item in
            item.idProduct == id
        }
        context.delete(productItem[0])
        save()
    }
}

struct SkinConditionBeforeCD {
    var stressLevel: Int
    var dryness: Int
    var redness: Int
    var swelling: Int
    var crust: Int
    var traces: Int
    var thickSkin: Int
    var itchy: Int
    var sleepLoss: Int
}

// MARK: - CRUD Journal
extension CDStorage {
    func createJournal(foodIntake: [IEAData], exposure: [IEAData], activities: [IEAData], skinCondition: SkinConditionBeforeCD, triggerAreas: [TriggerAreaItem]) {
        // Get the weather data
        
        // Append Skin Condition
        let newSC = SkinCondition(context: context)
        newSC.idCondition = UUID()
        newSC.sleepLoss = Int64(skinCondition.sleepLoss)
        newSC.itchiness = Int64(skinCondition.itchy)
        newSC.crust = Int64(skinCondition.crust)
        newSC.swelling = Int64(skinCondition.swelling)
        newSC.redness = Int64(skinCondition.redness)
        newSC.dryness = Int64(skinCondition.dryness)
        newSC.scratch = Int64(skinCondition.traces)
        newSC.poScorad = Int64(80)
        
        save()
        
        // Append journal
        let newJournal = Journal(context: context)
        newJournal.idJournal = UUID()
        if !foodIntake.isEmpty {
            newJournal.foodIntake = foodIntake as NSObject
        } else {
            newJournal.foodIntake = nil
        }
        if !exposure.isEmpty {
            newJournal.skinExposure = exposure as NSObject
        } else {
            newJournal.skinExposure = nil
        }
        if !activities.isEmpty {
            newJournal.activities = activities as NSObject
        } else {
            newJournal.activities = nil
        }
        newJournal.stressLevel = Int16(skinCondition.stressLevel)
        newJournal.dateAndTime = Date()
        newJournal.weatherCondition = nil
        newJournal.weatherTemp = 0.0
        newJournal.weatherHumid = 0.0
        newJournal.weatherTemp = 0.0
        newJournal.skinCondition = newSC.self
        
        save()
        
        // TODO: Kasih looping sesuai dengan array skin condition + gambarnya
        for trigger in triggerAreas {
            if let _ = trigger.image {
                addTriggerAreas(journal: newJournal, trigger: trigger)
            }
        }
    }
    
    func addTriggerAreas(journal: Journal, trigger: TriggerAreaItem) {
        let triggerArea = TriggerAreas(context: context)
        triggerArea.idTrigger = UUID()
        triggerArea.journal = journal
        triggerArea.areaName = trigger.name
        triggerArea.areaImage = trigger.safeImage() as NSObject
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

enum IEA: String {
    case activity = "Activity"
    case exposure = "Exposure"
    case intake = "Food Intake"
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
    
    func createIEA(_ type: IEA, name: String, thumb: String) {
        switch type {
        case .activity:
            let activity = Activity(context: self.context)
            activity.idActivity = UUID()
            activity.activityName = name
            activity.activityThumb = thumb
            activity.deletable = true
            activity.isFavorite = false
            save()
        case .exposure:
            let exposure = Exposure(context: self.context)
            exposure.idExposure = UUID()
            exposure.exposureName = name
            exposure.exposureThumb = thumb
            exposure.deletable = true
            exposure.isFavorite = false
            save()
        case .intake:
            let intake = FoodIntake(context: self.context)
            intake.idFoodIntake = UUID()
            intake.intakeName = name
            intake.intakeThumb = thumb
            intake.deletable = true
            intake.isFavorite = false
            save()
        }
    }
    
    func updateFavoriteIEA(_ type: IEA, id: UUID) {
        switch type {
        case .activity:
            let act = activities.value.filter { act in
                act.idActivity == id
            }[0]
            act.isFavorite.toggle()
        case .exposure:
            let act = envExposures.value.filter { act in
                act.idExposure == id
            }[0]
            act.isFavorite.toggle()
        case .intake:
            let act = foodIntakes.value.filter { act in
                act.idFoodIntake == id
            }[0]
            act.isFavorite.toggle()
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
            context.delete(foodIntakes.value.filter { item in
                item.idFoodIntake == id
            }[0])
        }
        save()
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
        } else if let intakeItems = controller.fetchedObjects as? [SkinCondition] {
            self.skinCondition.value = intakeItems
        } else if let intakeItems = controller.fetchedObjects as? [TriggerAreas] {
            self.triggerArea.value = intakeItems
        }
    }
}
