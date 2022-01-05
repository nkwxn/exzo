//
//  CDStorage+NewJournal+Extension.swift
//  exzo
//
//  Created by Nicholas on 23/11/21.
//

import CoreData
import CoreLocation

// swiftlint:disable function_parameter_count
extension CDStorage {
    func createNewJournal(
        rednessPart: [String],
        rednessScore: Int,
        swellingPart: [String],
        swellingScore: Int,
        scratchPart: [String],
        scratchScore: Int,
        foodIntakes: [IEAData],
        exposure: [IEAData],
        products: [ListProduct],
        stressLevel: Int,
        tisScorad: Double,
        completion: @escaping () -> Void
    ) {
        let newJournal = NewJournal(context: context)
        newJournal.id = UUID()
        newJournal.dateAndTime = Date()
        
        // 3 bagian penting pada scoring TIS
        newJournal.rednessPart = rednessPart as NSObject
        newJournal.rednessScore = Double(rednessScore)
        newJournal.swellingPart = swellingPart as NSObject
        newJournal.swellingScore = Double(swellingScore)
        newJournal.scratchPart = scratchPart as NSObject
        newJournal.scratchScore = Double(scratchScore)
        
        // Score akhir
        newJournal.tisScorad = tisScorad
        
        // Food Intake dan Exposure yang dimasukkin
        let intks = IEADatas(ieaDatas: foodIntakes)
        let expsrs = IEADatas(ieaDatas: exposure)
        newJournal.foodIntakes = intks
        newJournal.exposures = expsrs
        
        // Product Item (pake NSObject instead of just uuid krn kalo di delete kecenderungan untuk error nya tinggi)
        let prods = ListProducts(prods: products)
        newJournal.productIDs = prods
        
        // Stress Level
        newJournal.stressLevel = Double(stressLevel)
        
        newJournal.weatherHumid = 0
        newJournal.weatherTemp = 0
        newJournal.weatherPressure = 0
        self.save()
        completion()
    }
    
    func getSpecificNewJournal(id: UUID) -> NewJournal {
        let newJournal = newJournalItems.value.filter { newJournal in
            newJournal.id == id
        }[0]
        return newJournal
    }
    
    func updateNewJournal(
        id: UUID,
        rednessPart: [String],
        rednessScore: Int,
        swellingPart: [String],
        swellingScore: Int,
        scratchPart: [String],
        scratchScore: Int,
        foodIntakes: [IEAData],
        exposure: [IEAData],
        products: [ListProduct],
        stressLevel: Int,
        tisScorad: Double,
        completion: @escaping () -> Void
    ) {
        let toBeUpdated = self.newJournalItems.value.filter { tbu in
            tbu.id == id
        }[0]
        
        // 3 bagian penting pada scoring TIS
        toBeUpdated.rednessPart = rednessPart as NSObject
        toBeUpdated.rednessScore = Double(rednessScore)
        toBeUpdated.swellingPart = swellingPart as NSObject
        toBeUpdated.swellingScore = Double(swellingScore)
        toBeUpdated.scratchPart = scratchPart as NSObject
        toBeUpdated.scratchScore = Double(scratchScore)
        
        // Score akhir
        toBeUpdated.tisScorad = tisScorad
        
        // Food Intake dan Exposure yang dimasukkin
        let intks = IEADatas(ieaDatas: foodIntakes)
        let expsrs = IEADatas(ieaDatas: exposure)
        toBeUpdated.foodIntakes = intks
        toBeUpdated.exposures = expsrs
        
        // Product Item (pake NSObject instead of just uuid krn kalo di delete kecenderungan untuk error nya tinggi)
        let prods = ListProducts(prods: products)
        toBeUpdated.productIDs = prods
        
        // Stress Level
        toBeUpdated.stressLevel = Double(stressLevel)
        
        save()
        completion()
    }
    
    func deleteNewJournal(id: UUID, completion: () -> Void) {
        context.delete(newJournalItems.value.filter{ newJournal in
            newJournal.id == id
        }[0])
    }
}

// MARK: - Custom collections
// Source buat bljr: https://medium.com/@rezafarahani/store-array-of-custom-object-in-coredata-bea77b9eb629
public class IEADatas: NSObject, NSCoding {
    public var ieaDatas: [IEAData] = []
    
    enum Key: String {
        case ieaDatas = "ieaDatas"
    }
    
    init(ieaDatas: [IEAData]) {
        self.ieaDatas = ieaDatas
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(ieaDatas, forKey: Key.ieaDatas.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mRanges = coder.decodeObject(forKey: Key.ieaDatas.rawValue) as! [IEAData]
        self.init(ieaDatas: mRanges)
    }
}

public class IEAData: NSObject, NSCoding {
    var id: UUID
    var name: String
    var thumb: String
    
    init(id: UUID = UUID(), name: String, thumb: String) {
        self.id = id
        self.name = name
        self.thumb = thumb
    }
    
    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeObject(of: NSUUID.self, forKey: "iea_id") as UUID? ?? UUID()
        let name = coder.decodeObject(of: NSString.self, forKey: "iea_name") as String? ?? ""
        let thumb = coder.decodeObject(of: NSString.self, forKey: "iea_thumb") as String? ?? ""
        
        self.init(id: id, name: name, thumb: thumb)
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "iea_id")
        coder.encode(name, forKey: "iea_name")
        coder.encode(thumb, forKey: "iea_thumb")
    }
}

public class ListProducts: NSObject, NSCoding {
    public var prods: [ListProduct] = []
    
    enum Key: String {
        case listProduct = "listProduct"
    }
    
    init(prods: [ListProduct]) {
        self.prods = prods
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(prods, forKey: Key.listProduct.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mProd = coder.decodeObject(forKey: Key.listProduct.rawValue) as! [ListProduct]
        self.init(prods: mProd)
    }
}

public class ListProduct: NSObject, NSSecureCoding {
    var id: UUID
    var productCat: String
    var productName: String
    var selected: Bool = false
    
    init(id: UUID = UUID(), productCat: String, productName: String) {
        self.id = id
        self.productCat = productCat
        self.productName = productName
    }
    
    public static var supportsSecureCoding: Bool = true
    
    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeObject(of: NSUUID.self, forKey: "prod_id") as UUID? ?? UUID()
        let cat = coder.decodeObject(of: NSString.self, forKey: "prod_cat") as String? ?? ""
        let name = coder.decodeObject(of: NSString.self, forKey: "prod_name") as String? ?? ""
        
        self.init(id: id, productCat: cat, productName: name)
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "prod_id")
        coder.encode(productCat, forKey: "prod_cat")
        coder.encode(productName, forKey: "prod_name")
    }
}
