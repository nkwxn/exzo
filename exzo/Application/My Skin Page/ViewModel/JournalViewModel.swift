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
    
    @Published var journals = [NewJournal]()
    
    private var cancellable: AnyCancellable?
    
    init(
        journalPublisher: AnyPublisher<[NewJournal], Never> = CDStorage.shared.newJournalItems.eraseToAnyPublisher()
    ) {
        cancellable = journalPublisher.sink { journalItem in
            print("update journal")
            self.journals = journalItem
            print(self.journals)
        }
    }
    
    func deleteItem(index offset: IndexSet) {
        offset.map {
            guard let id = journals[$0].id else { return }
            journalModel.deleteJournal(with: id)
        }
    }
}
