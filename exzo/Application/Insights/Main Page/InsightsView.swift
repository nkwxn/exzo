//
//  InsightsView.swift
//  exzo
//
//  Created by Nicholas on 18/11/21.
//

import SwiftUI

enum InsightDetails: String {
    case foodIntake = "Food intake"
    case exposure = "Exposure"
    case stress = "Stress"
    case product = "Product / treatment"
    case skinCon = "Skin condition"
    
    func getDescription(items: [String]) -> String {
        switch self {
        case .foodIntake, .exposure:
            let type = self
            let itemsStr = items.joined(separator: ", ")
            return "You had \(self.rawValue.lowercased()) of \(itemsStr) this month. Try to minimize those \(type.rawValue.split(separator: " ").last!.lowercased())"
        default:
            return "hmm copywriting bener2"
        }
    }
    
    func getDescription(stressLevel: Int) -> String {
        getDescription(items: ["\(stressLevel)"])
    }
}

struct InsightRow: View {
    var detail: InsightDetails
    @State var title: String
    @State var desc: String
    
    init(_ detail: InsightDetails, items: [String]) {
        self.detail = detail
        self.title = detail.rawValue
        self.desc = detail.getDescription(items: items)
    }
    
    init(_ detail: InsightDetails, stressLevel: Int) {
        self.detail = detail
        self.title = detail.rawValue
        self.desc = detail.getDescription(stressLevel: stressLevel)
    }
    
    var body: some View {
        NavigationLink {
            InsightsDetailView(detail: detail)
        } label: {
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
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.accentColor)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
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
                                HStack {
                                    Spacer()
                                    NavigationLink("See details") {
                                        InsightsDetailView(detail: .skinCon)
                                    }
                                }
                            }
                        }
                        InsightRow(.foodIntake, items: ["dairy", "gluten"])
                        InsightRow(.exposure, items: ["dairy", "gluten"])
                        InsightRow(.stress, items: ["dairy", "gluten"])
                        InsightRow(.product, items: ["dairy", "gluten"])
                        
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
