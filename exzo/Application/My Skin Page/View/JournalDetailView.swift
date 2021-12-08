//
//  JournalDetailView.swift
//  exzo
//
//  Created by Daniella Stefani on 05/11/21.
//

import SwiftUI

class JournalDetailViewModel: ObservableObject {
    var journal: NewJournal
    
    init(_ journal: NewJournal) {
        self.journal = journal
    }
    
    func getRednessScore() -> Int {
        return Int(journal.rednessScore)
    }
    
    
}

struct JournalDetailHeadingView<Content: View>: View {
    var title: String
    var showDivider: Bool = true
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(Avenir(.headline).getFont().bold())
            content()
            if showDivider {
                Divider()
            }
        }
    }
}

struct JournalDetailView: View {
    @State var isEditing = false
    
    @ObservedObject var viewModel: JournalDetailViewModel
    let accentArr = [Color.brandy, Color.copper, Color.accentYellow, Color.brandy]
    
    init(journal: NewJournal) {
        self.viewModel = JournalDetailViewModel(journal)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(twoColumnsNavBar: true, title: "9 Oct 2021", subtitle: "09.00", showButton: .editButton) {
                isEditing.toggle()
            }
            VStack(alignment: .leading, spacing: 5) {
                JournalDetailHeadingView(title: "Asupan makanan") {
                    HStack(alignment: .center) {
                        if let foodIntakes = viewModel.journal.foodIntakes {
                            if foodIntakes.ieaDatas.isEmpty {
                                ZStack {
                                    Circle()
                                        .foregroundColor(accentArr[1])
                                        .frame(width: 66, height: 66, alignment: .center)
                                        .shadow(radius: 2)
                                    Text("N/A")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                            } else {
                                ForEach(0..<foodIntakes.ieaDatas.count, id: \.self) { idx in
                                    if idx < 4 {
                                        VStack {
                                            Image(foodIntakes.ieaDatas[idx].thumb)
                                                .resizable()
                                                .foregroundColor(.white)
                                                .frame(width: 66, height: 66, alignment: .center)
                                                .background {
                                                    Circle()
                                                        .foregroundColor(accentArr[idx])
                                                        .frame(width: 66, height: 66, alignment: .center)
                                                        .shadow(radius: 2)
                                                }
                                            Text(foodIntakes.ieaDatas[idx].name)
                                                .font(Avenir(.caption).getFont())
                                                .fontWeight(.semibold)
                                        }
                                    }
                                }
                            }
                        } else {
                            ZStack {
                                Circle()
                                    .foregroundColor(accentArr[1])
                                    .frame(width: 66, height: 66, alignment: .center)
                                    .shadow(radius: 2)
                                Text("N/A")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading, spacing: 5) {
                Text("Nilai stres")
                    .font(Avenir(.headline).getFont().bold())
                ZStack {
                    Circle()
                        .foregroundColor(accentArr[1])
                        .frame(width: 66, height: 66, alignment: .center)
                        .shadow(radius: 2)
                    Text("\(String(format: "%.0f", viewModel.journal.stressLevel))")
                        .foregroundColor(.white)
                        .bold()
                }
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Paparan")
                    .font(Avenir(.headline).getFont().bold())
                HStack(alignment: .center) {
                    if let exposure = viewModel.journal.exposures {
                        if exposure.ieaDatas.isEmpty {
                            ZStack {
                                Circle()
                                    .foregroundColor(accentArr[1])
                                    .frame(width: 66, height: 66, alignment: .center)
                                    .shadow(radius: 2)
                                Text("N/A")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        } else {
                            ForEach(0..<exposure.ieaDatas.count, id: \.self) { idx in
                                if idx < 4 {
                                    VStack {
                                        Image(exposure.ieaDatas[idx].thumb)
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 66, height: 66, alignment: .center)
                                            .background {
                                                Circle()
                                                    .foregroundColor(accentArr[idx])
                                                    .frame(width: 66, height: 66, alignment: .center)
                                                    .shadow(radius: 2)
                                            }
                                        Text(exposure.ieaDatas[idx].name)
                                            .font(Avenir(.caption).getFont())
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                        }
                    } else {
                        ZStack {
                            Circle()
                                .foregroundColor(accentArr[1])
                                .frame(width: 66, height: 66, alignment: .center)
                                .shadow(radius: 2)
                            Text("N/A")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Produk")
                    .font(Avenir(.headline).getFont().bold())
                Text("Moisturizer - Somethinc")
                    .font(Avenir(.headline).getFont())
                Divider()
                Text("Kondisi kulit")
                    .font(Avenir(.headline).getFont().bold())
                VStack {
                    JDSkinConditionView(score: Int(viewModel.journal.rednessValue), title: "Peradangan")
                    JDSkinConditionView(score: Int(viewModel.journal.swellingValue), title: "Pembengkakan")
                    JDSkinConditionView(score: Int(viewModel.journal.scratchValue), title: "Bekas garukan")
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct JDSkinConditionView: View {
    @State var score: Int
    @State var title: String
    
    var body: some View {
        HStack {
            Text("\(score)")
                .font(Lexend(.footnote).getFont().bold())
                .foregroundColor(Color.white)
                .background {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color.copper)
                    
                }
                .frame(width: 32, height: 32)
            Text(title)
                .font(Avenir(.footnote).getFont())
        }
    }
}
