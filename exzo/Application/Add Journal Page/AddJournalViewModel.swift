//
//  AddJournalViewModel.swift
//  exzo
//
//  Created by Nicholas on 04/11/21.
//

import SwiftUI
import Combine

struct BodyTriggerPart {
    var name: String
    var photo: UIImage?
}

enum JournalPageMode: String {
    case add
    case update
}

class AddJournalViewModel: ObservableObject {
    // Slider values (Stress Level)
    @Published var stressLevelSlider = 6.0
    @Published var sliderRange1 = 0...10.0
    @Published var sliderRange2 = 0...3.0
    
    // Grid Items (ambil dr core data or savingan dr cloudkit)
    @Published var foodIntake = [CategoryItem]()
    @Published var exposure = [CategoryItem]()
    @Published var activities = [CategoryItem]()
    
    private var intakeSelectedSubs: AnyCancellable?
    private var exposureSelectedSubs: AnyCancellable?
    private var activitySelectedSubs: AnyCancellable?
    
    var intakeSelect = [IEAData]()
    var exposureSelect = [IEAData]()
    var activitySelect = [IEAData]()
    
    // Skin conditions
    @Published var dryness = 2.0
    @Published var redness = 2.0
    @Published var swelling = 2.0
    @Published var crust = 2.0
    @Published var scratchTraces = 2.0
    @Published var thickSkin = 2.0
    
    @Published var itchiness = 6.0
    @Published var sleepLoss = 6.0
    
    // Trigger areas
    var triggerAreas = [BodyTriggerPart]()
    
    private var intakeSubs: AnyCancellable?
    private var exposureSubs: AnyCancellable?
    private var activitySubs: AnyCancellable?
    
    init() {
        intakeSubs = CDStorage.shared.foodIntakes.eraseToAnyPublisher().sink { intakes in
            self.foodIntake = intakes.filter { intake in
                intake.isFavorite
            }.map { intake -> CategoryItem in
                if let id = intake.idFoodIntake,
                   let thumb = intake.intakeThumb,
                   let name = intake.intakeName {
                    return CategoryItem(id: id, iconName: thumb, name: name, selected: false)
                }
                return CategoryItem(iconName: "Icon001", name: "NULL", selected: false)
            }
        }
        
        exposureSubs = CDStorage.shared.envExposures.eraseToAnyPublisher().sink { exposures in
            self.exposure = exposures.filter { exposure in
                exposure.isFavorite
            }.map { exposure -> CategoryItem in
                if let id = exposure.idExposure,
                   let thumb = exposure.exposureThumb,
                   let name = exposure.exposureName {
                    return CategoryItem(id: id, iconName: thumb, name: name, selected: false)
                }
                return CategoryItem(iconName: "Icon018", name: "NULL", selected: false)
            }
        }
        
        activitySubs = CDStorage.shared.activities.eraseToAnyPublisher().sink { activities in
            self.activities = activities.filter { activity in
                activity.isFavorite
            }.map { activity -> CategoryItem in
                if let id = activity.idActivity,
                   let thumb = activity.activityThumb,
                   let name = activity.activityName {
                    return CategoryItem(id: id, iconName: thumb, name: name, selected: false)
                }
                return CategoryItem(iconName: "Icon014", name: "NULL", selected: false)
            }
        }
    }
    
    // Done button pressed
    func doneBtnPressed() {
        // if user logged in, save to both cloudkit and coredata
        // else just save to core data
    }
}
