//
//  JournalRowView.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import SwiftUI
import Combine

class JournalRowViewModel: ObservableObject {
    var subs = Set<AnyCancellable>()
    var concerns = [String]()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        UDHelper.sharedUD.subsConcern { [weak self] value in
            self?.concerns = value
        }.store(in: &cancellables)
    }
}

struct JournalRowView: View {
    let journal: NewJournal
    let width = 300.0
    let accentArr = [Color.brandy, Color.copper, Color.accentYellow, Color.brandy]
    
    @ObservedObject var viewModel = JournalRowViewModel()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 19)
                .foregroundColor(Color.white)
                .shadow(radius: 10)
            
            VStack {
                HStack(alignment: .top) {
                    Text(journal.dateAndTime!, style: .time)
                        .font(Lexend(.subheadline).getFont())
                    Spacer()
                }
                Divider()
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        // MARK: - Asupan Makanan
                        if let foodIntakes = journal.foodIntakes {
                            if !foodIntakes.ieaDatas.isEmpty {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Asupan makanan")
                                        .font(Avenir(.subheadline).getFont())
                                    HStack(alignment: .center, spacing: -8) {
                                        ForEach(0..<foodIntakes.ieaDatas.count, id: \.self) { idx in
                                            if idx < 4 {
                                                Image(foodIntakes.ieaDatas[idx].thumb)
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 32, height: 32, alignment: .center)
                                                    .background {
                                                        Circle()
                                                            .foregroundColor(accentArr[idx])
                                                            .frame(width: 32, height: 32, alignment: .center)
                                                            .shadow(radius: 2)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        // MARK: - Skor Kondisi Kulit
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Kondisi Kulit")
                                .font(Avenir(.subheadline).getFont())
                            ZStack {
                                Circle()
                                    .foregroundColor(accentArr[1])
                                    .frame(width: 32, height: 32, alignment: .center)
                                    .shadow(radius: 2)
                                // skor peradangan + pembengkakan + bekas garukan
                                Text("\(String(format: "%.0f", journal.rednessScore + journal.scratchScore + journal.swellingScore))")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(Lexend(.footnote).getFont())
                                    .fontWeight(.semibold)
                                
                                
                                // Skor TIS Scorad
                                /*
                                Text("\(String(format: "%.0f", journal.tisScorad))")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(Lexend(.footnote).getFont())
                                    .fontWeight(.semibold)
                                 */
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        
                        // MARK: - Paparan
                        if let exposure = journal.exposures {
                            if !exposure.ieaDatas.isEmpty {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Paparan")
                                        .font(Avenir(.subheadline).getFont())
                                    HStack(alignment: .center, spacing: -8) {
                                        ForEach(0..<exposure.ieaDatas.count, id: \.self) { idx in
                                            if idx < 4 {
                                                Image(exposure.ieaDatas[idx].thumb)
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 32, height: 32, alignment: .center)
                                                    .background {
                                                        Circle()
                                                            .foregroundColor(accentArr[idx])
                                                            .frame(width: 32, height: 32, alignment: .center)
                                                            .shadow(radius: 2)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        // MARK: - Stress Level
                        if viewModel.concerns.contains(EczemaTriggers.stress.rawValue)
                            && journal.stressLevel != -1 {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Nilai stress")
                                    .font(Avenir(.subheadline).getFont())
                                ZStack {
                                    Circle()
                                        .foregroundColor(accentArr[1])
                                        .frame(width: 32, height: 32, alignment: .center)
                                        .shadow(radius: 2)
                                    Text("\(String(format: "%.0f", journal.stressLevel))")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(Lexend(.footnote).getFont())
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }
}
