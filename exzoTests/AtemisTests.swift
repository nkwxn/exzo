//
//  AtemisTests.swift
//  AtemisTests
//
//  Created by Nicholas on 26/10/21.
//

import XCTest
@testable import exzo

class AtemisTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCreateNewJournalTest() throws {
        CDStorage.shared.createNewJournal(
            rednessPart: ["arm", "elbow"],
            rednessScore: 3,
            swellingPart: ["neck"],
            swellingScore: 2,
            scratchPart: ["leftArm"],
            scratchScore: 2,
            foodIntakes: [IEAData(name: "Food", thumb: "Icon002")],
            exposure: [IEAData(name: "Sun", thumb: "Icon006")],
            products: [ListProduct(productCat: "Moisturizer", productName: "Cetapil")],
            stressLevel: 2
        ) {
            // completion handler
        }
        
        print(CDStorage.shared.newJournalItems.value)
        
//        if let prodys = CDStorage.shared.newJournalItems.value[0].productIDs as? ListProducts {
//            let productToCheck = prodys.prods[0]
//            XCTAssert(productToCheck.prod == "Skin Essence")
//            XCTAssertEqual(prodys.prods[0], "Skin Essence")
//        }
    }
    
    func testReadJournal() throws {
        let journalItems = CDStorage.shared.newJournalItems.value
        XCTAssert(journalItems.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
