//
//  InsightsView.swift
//  exzo
//
//  Created by Nicholas on 18/11/21.
//

import SwiftUI

struct InsightRow: View {
    @State var title: String
    @State var desc: String
    
    var body: some View {
        RoundedSquareContainer(autoPadding: true) {
            HStack(spacing: 16) {
                Image("icon_products")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title3)
                        .bold()
                    Text(desc)
                }
            }
        }
    }
}

struct InsightsView: View {
    @State var score = 3
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavBarView(twoColumnsNavBar: false, title: "Insights", subtitle: nil, showButton: .addButton) {
                    // Action untuk buka settings
                }
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading) {
                        Text("Here is your insights for this month!")
                            .font(Lexend(.title2).getFont())
                            .foregroundColor(.copper)
                            .bold()
                            .padding(.top)
                            .padding(.horizontal)
                        RoundedSquareContainer(autoPadding: true) {
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Spacer()
                                    Image("ResultOnboarding\(score)")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding()
                                        .background {
                                            Circle()
                                                .foregroundColor(.antique)
                                        }
                                    Spacer()
                                }
                                Text("You have score of **\(score)** which indicates that you have **moderate eczema**")
                                Text("This means that your eczema **covers pretty large areas** of your skin, **periodically feels itchy,** and **visible skin signs.**")
                            }
                        }
                        NavigationLink {
                            InsightsDetail()
                        } label: {
                            InsightRow(title: "Food intake", desc: "You had high food intakes of dairy and gluten this month. Try to minimize those intakes.")
                        }
                        .buttonStyle(PlainButtonStyle())

                        InsightRow(title: "Exposure", desc: "You had high exposure of dust and pollen this month. Try to minimize those exposures.")
                        InsightRow(title: "Stress", desc: "You did not suffer from stress this month. Keep maintain your child's stress.")
                        InsightRow(title: "Product / treatment", desc: "You used high amount of Lotion: Cerave SA. Try to minimize those products.")
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}
