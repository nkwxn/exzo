//
//  MySkinViewModel.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import Foundation
import Combine
import UIKit

class JournalViewModel: ObservableObject {
    var journalModel = CDStorage.shared
    
    @Published var journals = [Journal]()
    
    private var cancellable: AnyCancellable?
    
    init(
        journalPublisher: AnyPublisher<[Journal], Never> = CDStorage.shared.journalItems.eraseToAnyPublisher()
    ) {
        cancellable = journalPublisher.sink { journalItem in
            print("update journal")
            self.journals = journalItem
            print(self.journals)
        }
    }
    
    func deleteItem(index offset: IndexSet) {
        offset.map {
            guard let id = journals[$0].idJournal else { return }
            journalModel.deleteJournal(with: id)
        }
    }
}
