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
    
    @Published var deleteConfirmation = false
    var toBeDeleted: NewJournal?
    
    @Published var selectedDate: Date = Date()
    @Published var currentPage: Date = Date()
        
    @Published var journals = [NewJournal]()
    @Published var filteredJournal = [NewJournal]()
    
    private var cancellable: AnyCancellable?
    private var dateCancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    init(
        journalPublisher: AnyPublisher<[NewJournal], Never> = CDStorage.shared.newJournalItems.eraseToAnyPublisher()
    ) {
        cancellable = journalPublisher.sink { journalItem in
            self.journals = journalItem
            self.filterJournal(selectedDate: self.selectedDate)
        }
        
        addSubscribers()
    }
    
    func addSubscribers() {
        dateCancellable = $selectedDate.eraseToAnyPublisher().sink { date in
            self.filterJournal(selectedDate: date)
            print("From combine: \(date)")
        }
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    func deleteItem(index offset: IndexSet) {
        offset.map {
            guard let id = journals[$0].id else { return }
            journalModel.deleteNewJournal(id: id) {
                print("Delete completed")
            }
        }
    }
    
    func deleteItem(_ journal: NewJournal) {
        journalModel.deleteNewJournal(id: journal.id!) {
            print("Delete completed")
        }
    }
    
    func deleteItem(id: UUID) {
        journalModel.deleteNewJournal(id: id) { 
            print("Delete completed ")
        }
    }
    
    public func filterJournal(selectedDate: Date) {
        let dateFormat = DateFormatter()
        dateFormat.timeStyle = .none
        dateFormat.dateStyle = .full
        
        self.filteredJournal = journals.filter { journal in
            if let journalDate = journal.dateAndTime {
                return dateFormat.string(from: journalDate) == dateFormat.string(from: selectedDate)
            } else {
                return false
            }
        }
    }
}
