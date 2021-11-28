//
//  JournalDetailView.swift
//  exzo
//
//  Created by Daniella Stefani on 05/11/21.
//

import SwiftUI

struct JournalDetailView: View {
    @State var isEditing = false
    
    let journal: NewJournal
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(twoColumnsNavBar: true, title: "9 Oct 2021", subtitle: "09.00", showButton: .editButton) {
                isEditing.toggle()
            }
            
            VStack(alignment: .leading) {
                Text("Food intake")
                    .font(Avenir(.headline).getFont().bold())
                HStack {
                    VStack(alignment: .center, spacing: 8) {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .foregroundColor(Color.white)
                            .background {
                                Circle()
                                    .frame(width: 66, height: 66)
                                    .foregroundColor(Color.accentYellow)
                                
                            }
                            .frame(width: 66, height: 66)
                        Text("Gluten")
                            .font(Avenir(.caption).getFont())
                            .fontWeight(.semibold)
                    }
                }
                
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Stress level")
                    .font(Avenir(.headline).getFont().bold())
                Text("\(journal.stressLevel)")
                    .font(Avenir(.title).getFont().bold())
                    .foregroundColor(Color.white)
                    .background {
                        Circle()
                            .frame(width: 66, height: 66)
                            .foregroundColor(Color.copper)
                        
                    }
                    .frame(width: 66, height: 66)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Exposure")
                    .font(Avenir(.headline).getFont().bold())
                HStack {
                    VStack(alignment: .center, spacing: 8) {
                        Image(systemName: "car.fill")
                            .resizable()
                            .foregroundColor(Color.white)
                            .background {
                                Circle()
                                    .frame(width: 66, height: 66)
                                    .foregroundColor(Color.accentYellow)
                                
                            }
                            .frame(width: 66, height: 66)
                        Text("Car")
                            .font(Avenir(.caption).getFont())
                            .fontWeight(.semibold)
                    }
                }
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Product")
                    .font(Avenir(.headline).getFont().bold())
                Text("Moisturizer - Somethinc")
                    .font(Avenir(.headline).getFont())
                Divider()
                Text("Skin conditions")
                    .font(Avenir(.headline).getFont().bold())
                VStack {
                    HStack {
                        Text("2")
                            .font(Lexend(.footnote).getFont().bold())
                            .foregroundColor(Color.white)
                            .background {
                                Circle()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(Color.copper)
                                
                            }
                            .frame(width: 32, height: 32)
                        Text("Dryness")
                            .font(Lexend(.footnote).getFont())
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}
