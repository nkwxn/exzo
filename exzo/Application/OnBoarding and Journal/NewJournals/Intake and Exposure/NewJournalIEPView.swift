//
//  NewJournalIntakeExposureView.swift
//  exzo
//
//  Created by Nicholas on 26/11/21.
//

import SwiftUI
import Combine

//struct FEGridView: View {
//    inputMode.
//    let gridItem = Array(repeating: GridItem(), count: 5)
//
//    var body: some View {
//        LazyVGrid(columns: gridItem) {
//
//        }
//    }
//}

struct ListProduct {
    var id: UUID
    var productCat: String
    var productName: String
    var selected: Bool = false
}

struct JournalProductListView: View {
    @Binding var productList: [ListProduct]
    
    var body: some View {
        ForEach(productList, id: \.id) { item in
            HStack {
                Text(item.productCat)
                    .foregroundColor(.primary)
                Spacer()
                Text(item.productName)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(item.selected ? .copper : .white)
            }
        }
    }
}

class IEPViewModel: ObservableObject {
    @Published var ieaData = [CategoryItem]()
    @Published var medProd = [ListProduct]()
    
    private var cancellable: AnyCancellable?
    
    init(_ inputMode: EczemaTriggers) {
        switch inputMode {
        case .foodIntake:
            self.cancellable = CDStorage.shared.foodIntakes.eraseToAnyPublisher().sink { items in
                self.ieaData = items.filter { item in
                    item.isFavorite
                }.map { item -> CategoryItem in
                    if let id = item.idFoodIntake,
                       let thumb = item.intakeThumb,
                       let name = item.intakeName {
                        return CategoryItem(id: id, iconName: thumb, name: name, selected: false)
                    }
                    return CategoryItem(iconName: "Icon001", name: "NULL", selected: false)
                }
            }
            medProd = []
        case .exposure:
            self.cancellable = CDStorage.shared.envExposures.eraseToAnyPublisher().sink { items in
                self.ieaData = items.filter({ item in
                    item.isFavorite
                }).map({ item -> CategoryItem in
                    if let id = item.idExposure,
                       let thumb = item.exposureThumb,
                       let name = item.exposureName {
                        return CategoryItem(id: id, iconName: thumb, name: name, selected: false)
                    }
                    return CategoryItem(iconName: "Icon001", name: "NULL", selected: false)
                })
            }
            self.medProd = []
        case .stress:
            print("Stress level have been defined. Please SKIP THIS")
            
        case .medProd:
            cancellable = CDStorage.shared.productItems.eraseToAnyPublisher().sink { items in
                self.medProd = items.map { item -> ListProduct in
                    if let id = item.idProduct,
                       let name = item.productName,
                       let category = item.productType {
                        return ListProduct(id: id, productCat: category, productName: name)
                    }
                    return ListProduct(id: UUID(), productCat: "Category", productName: "Name")
                }
            }
            self.ieaData = []
        }
    }
}

struct NewJournalIEPView: View {
    @Environment(\.dismiss) var dismiss
    
    var inputMode: EczemaTriggers
    @ObservedObject var viewModel: JournalInputViewModel
    @ObservedObject var iepViewModel: IEPViewModel
    
    @State var nextPage = false
    
    init(_ inputMode: EczemaTriggers, viewModel: JournalInputViewModel) {
        self.inputMode = inputMode
        self.viewModel = viewModel
        
        // Buat combine di Intake, exposure, and product
        iepViewModel = IEPViewModel(inputMode)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            CustomProgressView(percent: .constant(0.6))
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(inputMode.rawValue)
                        .font(Lexend(.title2).getFont().bold())
                    Button {
                        
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    
                }
                Text("\(inputMode.getDescOne()) apa saja yang anak Anda \(inputMode.getDescTwo()) hari ini?")
                ScrollView(.vertical, showsIndicators: true) {
                    switch inputMode {
                    case .foodIntake:
                        CategoryGrid($iepViewModel.ieaData, color: .accentYellow)
                    case .exposure:
                        CategoryGrid($iepViewModel.ieaData, color: .copper)
                    case .stress:
                        Text("Should not belongs here")
                    case .medProd:
                        JournalProductListView(productList: $iepViewModel.medProd)
                    }
                    Button("Tambah \(inputMode.rawValue)") {
                        // Show or hide modal
                    }
                    .buttonStyle(ExzoButtonStyle(type: .secondary))
                }
                Button("Lanjut") {
                    switch inputMode {
                    case .foodIntake:
                        if viewModel.chosenTriggerCategory.contains(where: { cate in
                            let isExposure = cate == EczemaTriggers.exposure.rawValue
                            let isProd = cate == EczemaTriggers.medProd.rawValue
                            
                            return isExposure || isProd
                        }) {
                            nextPage.toggle()
                        } else {
                            dismiss()
                        }
                    case .exposure:
                        if viewModel.chosenTriggerCategory.contains(where: { cate in
                            let isProd = cate == EczemaTriggers.medProd.rawValue
                            
                            return isProd
                        }) {
                            nextPage.toggle()
                        } else {
                            dismiss()
                        }
                    default:
                        dismiss()
                    }
                }
                .buttonStyle(ExzoButtonStyle(type: .primary))
                NavigationLink("Lanjut", isActive: $nextPage, destination: {
                    switch inputMode {
                    case .foodIntake:
                        if viewModel.chosenTriggerCategory.contains(EczemaTriggers.exposure.rawValue) {
                            NewJournalIEPView(.exposure, viewModel: viewModel)
                        } else if viewModel.chosenTriggerCategory.contains(EczemaTriggers.medProd.rawValue) {
                            NewJournalIEPView(.medProd, viewModel: viewModel)
                        }
                    case .exposure:
                        if viewModel.chosenTriggerCategory.contains(EczemaTriggers.medProd.rawValue) {
                            NewJournalIEPView(.medProd, viewModel: viewModel)
                        }
                    case .stress:
                        Text("Should never execute")
                    case .medProd:
                        Text("Should dismiss modal")
                    }
                })
                    .hidden()
            }
        }
        .padding()
        .navigationTitle(inputMode.rawValue)
    }
}

struct NewJournalIntakeExposureView_Previews: PreviewProvider {
    static var previews: some View {
        NewJournalIEPView(.foodIntake, viewModel: JournalInputViewModel(.child, mode: .onboarding))
        NewJournalIEPView(.exposure, viewModel: JournalInputViewModel(.child, mode: .onboarding))
    }
}
