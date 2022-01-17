//
//  JournalDetailView.swift
//  exzo
//
//  Created by Daniella Stefani on 05/11/21.
//

import SwiftUI

class JournalDetailViewModel: ObservableObject {
    var journal: NewJournal
    @Published var isEditing = false
    let accentArr = [Color.brandy, Color.copper, Color.accentYellow, Color.brandy]
    
    // Item of concerns
    let concerns = UDHelper.sharedUD.getConcern()
    
    init(_ journal: NewJournal) {
        self.journal = journal
    }
    
    func getJournalDate() -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        guard let safeDate = journal.dateAndTime
        else { return df.string(from: Date()) }
        return df.string(from: safeDate)
    }
    
    func getJournalTime() -> String {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .short
        return df.string(from: journal.dateAndTime ?? Date())
    }
    
    func getRednessScore() -> Int {
        return Int(journal.rednessScore)
    }
    
    func getJournalArray(_ journalSect: IEA) -> [IEAData] {
        switch journalSect {
        case .activity:
            // ini ga ada bund
            return []
        case .exposure:
            guard let array = journal.exposures
            else { return [] }
            return array.ieaDatas
        case .intake:
            guard let array = journal.foodIntakes
            else { return [] }
            return array.ieaDatas
        }
    }
    
    func getProductUsed() -> [String] {
        guard let products = journal.productIDs else { return ["None of the products are used"] }
        return products.prods.map { products -> String in
            return "\(ProductType(rawValue: products.productCat)?.getLocalizedName() ?? "") - \(products.productName)"
        }
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
                .padding(.bottom)
            if showDivider {
                Divider()
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

struct JournalDetailCircleGrid: View {
    enum GridMode {
        case gridItem, number
    }
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)
    let accentArr = [Color.brandy, Color.copper, Color.accentYellow, Color.brandy]
    let gridMode: GridMode
    var collectionData: [IEAData]
    var numberContent: Int
    
    init(collectionData: [IEAData]) {
        self.gridMode = .gridItem
        self.collectionData = collectionData
        numberContent = 0
    }
    
    init(_ number: Int) {
        self.gridMode = .number
        self.collectionData = [IEAData]()
        self.numberContent = number
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            switch gridMode {
            case .gridItem:
                if collectionData.isEmpty {
                    CircleNum(text: "N/A")
                } else {
                    ForEach(collectionData, id: \.self) { gridData in
                        VStack {
                            Image(gridData.thumb)
                                .resizable()
                                .foregroundColor(.white)
                                .background {
                                    Circle()
                                        .foregroundColor(accentArr[Int.random(in: 0...3)])
                                }
                            Text(gridData.name)
                                .font(Avenir(.body).getFont())
                                .fontWeight(.semibold)
                                .lineLimit(1)
                        }
                        .aspectRatio(0.7, contentMode: .fit)
                    }
                }
            case .number:
                CircleNum(text: "\(numberContent)")
            }
        }
    }
    
    struct CircleNum: View {
        var text: String
        
        var body: some View {
            ZStack {
                Circle()
                    .foregroundColor(.copper)
                Text(text)
                    .font(Lexend(.title).getFont())
                    .foregroundColor(.white)
                    .bold()
                    .padding()
            }
            .aspectRatio(1, contentMode: .fit)
        }
    }
}

struct JournalDetailView: View {
    
    @ObservedObject var viewModel: JournalDetailViewModel
    
    init(journal: NewJournal) {
        self.viewModel = JournalDetailViewModel(journal)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(
                twoColumnsNavBar: true,
                title: viewModel.getJournalDate(),
                subtitle: viewModel.getJournalTime(),
                showButton: .editButton
            ) {
                viewModel.isEditing.toggle()
            }
            .sheet(isPresented: $viewModel.isEditing) {
                // onDismiss: update the content
                let toBeUpdated = CDStorage.shared.getSpecificNewJournal(id: viewModel.journal.id ?? UUID())
                self.viewModel.journal = toBeUpdated
            } content: {
                SkinConditionJournalView(journalContent: viewModel.journal)
                    .environment(\.modalMode, $viewModel.isEditing)
            }
            
            // TODO: Kasih if statement agar bs muncul / tidak sesuai dengan User Defaults
            ScrollView(.vertical, showsIndicators: true) {
                if viewModel.concerns.contains(EczemaTriggers.foodIntake.rawValue) {
                    JournalDetailHeadingView(title: "Asupan makanan") {
                        JournalDetailCircleGrid(collectionData: viewModel.getJournalArray(.intake))
                    }
                }
                if viewModel.concerns.contains(EczemaTriggers.stress.rawValue) {
                    JournalDetailHeadingView(title: "Tingkat stres") {
                        JournalDetailCircleGrid(Int(viewModel.journal.stressLevel))
                    }
                }
                if viewModel.concerns.contains(EczemaTriggers.exposure.rawValue) {
                    JournalDetailHeadingView(title: "Paparan") {
                        JournalDetailCircleGrid(collectionData: viewModel.getJournalArray(.exposure))
                    }
                }
                if viewModel.concerns.contains(EczemaTriggers.medProd.rawValue) && !viewModel.getProductUsed().isEmpty {
                    JournalDetailHeadingView(title: "Produk") {
                        VStack(alignment: .leading) {
                            ForEach(viewModel.getProductUsed(), id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                JournalDetailHeadingView(title: "Kondisi kulit") {
                    VStack(alignment: .leading) {
                        JDSkinConditionView(score: Int(viewModel.journal.rednessScore), title: "Peradangan")
                        JDSkinConditionView(score: Int(viewModel.journal.swellingScore), title: "Pembengkakan")
                        JDSkinConditionView(score: Int(viewModel.journal.scratchScore), title: "Bekas garukan")
                    }
                }
                Spacer()
            }
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
                .font(Avenir.shared.getFont().bold())
                .foregroundColor(Color.white)
                .background {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color.copper)
                    
                }
                .frame(width: 32, height: 32)
            Text(title)
                .font(Avenir.shared.getFont())
        }
    }
}
