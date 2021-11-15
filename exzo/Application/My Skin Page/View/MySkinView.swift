//
//  MySkinPage.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import SwiftUI

struct CalendarHeader: View {
    @Binding var selectedDate: Date
    @Binding var currentPage: Date
    
    var body: some View {
        // Headings
        HStack {
            Button { self.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self.currentPage)!
            } label: {
                Image(systemName: "chevron.left")
            }
            .frame(height: 118, alignment: .top)
            
            CalendarView(dateSelected: $selectedDate, pageCurrent: $currentPage)
                .frame(width: 300, height: 225, alignment: .init(horizontal: .center, vertical: .center))
            
            Button { self.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self.currentPage)!
            } label: {
                Image(systemName: "chevron.right")
            }
            .frame(height: 118, alignment: .top)
        }
        
    }
}

struct MySkinView: View {
    @StateObject var journalViewModel = JournalViewModel()
    @State var isAddingJournal = false
    @ObservedObject private var calendarModel = CalendarModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // Header view needs to be pinned on the top
                
                LazyVStack(alignment: .center, spacing: 0, pinnedViews: [.sectionHeaders]) {
                    // Parallax weather header
                    WeatherView()
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.bottom, 20)
                    Section {
                        if journalViewModel.journals.isEmpty {
                            ZStack {
                                Color(uiColor: .systemGray5)
                                    .cornerRadius(15)
                                Text("No skin history at the moment")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                                .padding(.horizontal)
                        } else {
                            ForEach(Array(journalViewModel.journals.enumerated()), id: \.0) {
                                JournalRowView(journal: $1)
                                    .padding(.horizontal)
                                    .padding(.bottom, 14)
                            }
                        }
                    } header: {
                        ZStack(alignment: .bottom) {
                            Color.white
                                .ignoresSafeArea(.all, edges: .top)
                            CalendarHeader(selectedDate: $calendarModel.selectedDate, currentPage: $calendarModel.currentPage)
                            VStack(alignment: .leading, spacing: 20) {
                                Button {
                                    isAddingJournal = true
                                } label: {
                                    Image(systemName: "plus")
                                    Text("Add Journal")
                                }.buttonStyle(ExzoButtonStyle(type: .primary))
                                Text("Skin History")
                                    .font(Lexend(.headline).getFont().bold())
                            }
                            .padding()
                        }
                    }
                }
                .sheet(isPresented: $isAddingJournal) {
                    AddJournalView()
                }
            }
            .navigationBarHidden(true)
            .overlay {
                VStack {
                    Image("NavBar-Background")
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .clipShape(Rectangle())
                        .ignoresSafeArea(.all, edges: .top)
                    Spacer()
                }
            }
//            .onChange(of: isAddingJournal) { newValue in
//                calendarModel.selectedDate = Date()
//            }
        }
    }
}

struct MySkinView_Previews: PreviewProvider {
    static var previews: some View {
        MySkinView()
    }
}
