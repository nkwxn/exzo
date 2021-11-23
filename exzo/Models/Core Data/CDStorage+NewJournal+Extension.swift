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
        products: [String],
        stressLevel: Int
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
        
        // Food Intake dan Exposure yang dimasukkin
        newJournal.foodIntakes = foodIntakes as NSObject
        newJournal.exposures = exposure as NSObject
        
        // Product Item (pake NSObject instead of just uuid krn kalo di delete kecenderungan untuk error nya tinggi)
        newJournal.productIDs = products as NSObject
        
        // Stress Level
        newJournal.stressLevel = Double(stressLevel)
        
        if let locationData = CLLocationManager().location {
            // get weather data
            APIRequest.fetchWeather(coordinate: locationData.coordinate) { apiData in
                newJournal.weatherHumid = apiData.main.humidity
                newJournal.weatherTemp = apiData.main.temp
                newJournal.weatherPressure = apiData.main.pressure
            } failCompletion: { failMsg in
                print(failMsg)
            }
        }
        save()
    }
    
    func getSpecificNewJournal(id: UUID) -> NewJournal {
        let newJournal = newJournalItems.value.filter { newJournal in
            newJournal.id == id
        }[0]
        return newJournal
    }
}
