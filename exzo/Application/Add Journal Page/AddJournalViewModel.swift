//
//  AddJournalViewModel.swift
//  exzo
//
//  Created by Nicholas on 04/11/21.
//

import SwiftUI
import Combine

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
    @Published var triggerAreas = [TriggerAreaItem(name: "Right arm", image: UIImage(named: "login_image")), TriggerAreaItem(name: "Neck", image: nil)]
    
    private var intakeSubs: AnyCancellable?
    private var exposureSubs: AnyCancellable?
    private var activitySubs: AnyCancellable?
    
    private var intakeSelectSubs: AnyCancellable?
    private var exposureSelectSubs: AnyCancellable?
    private var activitySelectSubs: AnyCancellable?
    
    // doneDisabled
    @Published var doneDisabled = true
    
    // swiftlint:disable function_body_length
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
        
        intakeSelectSubs = $foodIntake.eraseToAnyPublisher().sink { items in
            self.intakeSelect = items.filter { item in
                item.selected
            }.map { item -> IEAData in
                IEAData(name: item.name, thumb: item.iconName)
            }
            self.toggleDoneBtnDisabled()
        }
        
        exposureSelectSubs = $exposure.eraseToAnyPublisher().sink { items in
            self.exposureSelect = items.filter { item in
                item.selected
            }.map { item -> IEAData in
                IEAData(name: item.name, thumb: item.iconName)
            }
            self.toggleDoneBtnDisabled()
        }
        
        activitySelectSubs = $activities.eraseToAnyPublisher().sink { items in
            self.activitySelect = items.filter { item in
                item.selected
            }.map { item -> IEAData in
                IEAData(name: item.name, thumb: item.iconName)
            }
            self.toggleDoneBtnDisabled()
        }
    }
    
    func toggleDoneBtnDisabled() {
        if self.activitySelect.isEmpty && self.intakeSelect.isEmpty && self.exposureSelect.isEmpty {
            // if one of three has no content at all
            self.doneDisabled = true
        } else {
            self.doneDisabled = false
        }
    }
    
    // Done button pressed
    func doneBtnPressed(completion: @escaping (Bool) -> Void) {
        // if user logged in, save to both cloudkit and coredata
        CDStorage.shared.createJournal(
            foodIntake: intakeSelect, exposure: exposureSelect, activities: activitySelect,
            skinCondition: SkinConditionBeforeCD(
                stressLevel: Int(stressLevelSlider), dryness: Int(dryness), redness: Int(redness),
                swelling: Int(swelling), crust: Int(crust), traces: Int(scratchTraces),
                thickSkin: Int(thickSkin), itchy: Int(itchiness), sleepLoss: Int(sleepLoss)
            )
        )
        
        completion(true)
        
    }
}
