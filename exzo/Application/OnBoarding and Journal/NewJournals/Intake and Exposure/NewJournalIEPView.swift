//
//  NewJournalIntakeExposureView.swift
//  exzo
//
//  Created by Nicholas on 26/11/21.
//

import SwiftUI
import Combine

struct JournalProductListView: View {
    @Binding var productList: [ListProduct]
    
    var body: some View {
        ForEach(productList, id: \.id) { item in
            ProductListRow(product: item) { prodItem, selected in
                
            }
        }
    }
}

struct ProductListRow: View {
    var product: ListProduct
    @State var selected = false
    var completion: (ListProduct, Bool) -> Void
    
    var body: some View {
        Button {
            // action
            self.selected.toggle()
            completion(product, selected)
        } label: {
            // label
            HStack {
                Text(ProductType(rawValue: product.productCat ?? "")?.getLocalizedName() ?? "")
                    .foregroundColor(selected ? .white : .primary)
                Spacer()
                Text(product.productName)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(selected ? .copper : .white)
            }
            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.1), radius: 10, x: 1, y: 3)
        }
    }
}

class IEPViewModel: ObservableObject {
    @Published var ieaData = [CategoryItem]()
    @Published var medProd = [ListProduct]()
    
    @Published var selectedIEA = [IEAData]()
    @Published var selectedMedProd = [ListProduct]()
    
    private var cancellable: AnyCancellable?
    var selectionCancellable: AnyCancellable?
    
    // swiftlint:disable function_body_length
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
            
            selectionCancellable = $ieaData.eraseToAnyPublisher().sink { items in
                self.selectedIEA = items.filter { item in
                    item.selected
                }.map { item -> IEAData in
                    IEAData(id: item.id, name: item.name, thumb: item.iconName)
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
            
            selectionCancellable = $ieaData.eraseToAnyPublisher().sink { items in
                self.selectedIEA = items.filter { item in
                    item.selected
                }.map { item -> IEAData in
                    IEAData(id: item.id, name: item.name, thumb: item.iconName)
                }
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
            
            selectionCancellable = $medProd.eraseToAnyPublisher().sink { items in
                self.selectedMedProd = items.filter { item in
                    item.selected
                }
            }
            self.ieaData = []
        }
    }
}

struct NewJournalIEPView: View {
    @Environment(\.modalMode) var modalMode
    
    var inputMode: EczemaTriggers
    @ObservedObject var viewModel: JournalInputViewModel
    @ObservedObject var iepViewModel: IEPViewModel
    
    @State var nextPage = false
    @State var buttonText = "Lanjut"
    @State var addThingsShown = false
    
    init(_ inputMode: EczemaTriggers, viewModel: JournalInputViewModel) {
        self.inputMode = inputMode
        self.viewModel = viewModel
        
        // Buat combine di Intake, exposure, and product
        iepViewModel = IEPViewModel(inputMode)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomProgressView(percent: .constant(0.6))
                .padding()
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(inputMode.rawValue)
                            .font(Lexend(.title2).getFont().bold())
                        Button {
                            
                        } label: {
                            Image(systemName: "info.circle")
                        }
                        
                    }
                    Text("\(inputMode.getDescOne()) apa saja yang \(viewModel.category == .child ? "anak" : "") Anda \(inputMode.getDescTwo()) hari ini?")
                }
                .padding(.horizontal)
                ScrollView(.vertical, showsIndicators: true) {
                    switch inputMode {
                    case .foodIntake:
                        CategoryGrid($iepViewModel.ieaData, color: .accentYellow)
                            .padding(.horizontal)
                    case .exposure:
                        CategoryGrid($iepViewModel.ieaData, color: .copper)
                            .padding(.horizontal)
                    case .stress:
                        Text("Should not belongs here")
                            .padding(.horizontal)
                    case .medProd:
                        ForEach(iepViewModel.medProd, id: \.id) { item in
                            ProductListRow(product: item) { prodItem, selected in
                                print("\(prodItem.productName) - \(selected)")
                                if selected {
                                    viewModel.chosenProducts.append(prodItem)
                                } else {
                                    viewModel.chosenProducts.removeAll { listProductItem in
                                        listProductItem.id == prodItem.id
                                    }
                                }
                                print(viewModel.chosenProducts)
                            }
                            .padding(.horizontal)
                        }
                    }
                    Button("Tambah \(inputMode.rawValue)") {
                        // Show or hide modal
                        self.addThingsShown.toggle()
                    }
                    .padding(.horizontal)
                    .buttonStyle(ExzoButtonStyle(type: .secondary))
                    .sheet(isPresented: $addThingsShown) {
                        // on dismiss
                    } content: {
                        switch inputMode {
                        case .foodIntake:
                            NavigationView {
                                AddFEAView(category: .intake, accent: .accentYellow)
                            }
                        case .exposure:
                            NavigationView {
                                AddFEAView(category: .exposure, accent: .copper)
                            }
                        case .medProd:
                            AddProduct()
                        case .stress:
                            Text("Should never show prodict")
                        }
                    }
                    .onChange(of: iepViewModel.selectedIEA) { newValue in
                        switch inputMode {
                        case .foodIntake:
                            viewModel.chosenFoodIntakes = newValue
                        case .exposure:
                            viewModel.chosenExposure = newValue
                        default:
                            print("Insufficient category")
                        }
                    }
                    .onChange(of: iepViewModel.selectedMedProd) { newValue in
                        switch inputMode {
                        case .medProd:
                            viewModel.chosenProducts = newValue
                        default:
                            print("Insufficient category")
                        }
                    }
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
                            viewModel.finishInput {
                                // Completion
                                dismissModal()
                                viewModel.pushNavToTimer()
                            }
                        }
                    case .exposure:
                        if viewModel.chosenTriggerCategory.contains(where: { cate in
                            let isProd = cate == EczemaTriggers.medProd.rawValue
                            
                            return isProd
                        }) {
                            nextPage.toggle()
                        } else {
                            viewModel.finishInput {
                                // Completion
                                dismissModal()
                                viewModel.pushNavToTimer()
                            }
                        }
                    case .medProd:
                        viewModel.finishInput {
                            // Completion
                            dismissModal()
                            viewModel.pushNavToTimer()
                        }
                    default:
                        dismissModal()
                    }
                }
                .buttonStyle(ExzoButtonStyle(type: .primary))
                .padding(.horizontal)
                .onAppear {
                    switch inputMode {
                    case .foodIntake:
                        if viewModel.chosenTriggerCategory.contains(where: { cate in
                            let isExposure = cate == EczemaTriggers.exposure.rawValue
                            let isProd = cate == EczemaTriggers.medProd.rawValue
                            
                            return isExposure || isProd
                        }) {
                            self.buttonText = "Lanjut"
                        } else {
                            self.buttonText = "Selesai"
                        }
                    case .exposure:
                        if viewModel.chosenTriggerCategory.contains(where: { cate in
                            let isProd = cate == EczemaTriggers.medProd.rawValue
                            
                            return isProd
                        }) {
                            self.buttonText = "Lanjut"
                        } else {
                            self.buttonText = "Selesai"
                        }
                    default:
                        self.buttonText = "Selesai"
                    }
                }
                NavigationLink(buttonText, isActive: $nextPage) {
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
                }
                    .hidden()
            }
        }
        .navigationTitle(inputMode.rawValue)
    }
    
    func dismissModal() {
        // Save to core data (NewJournal)
        
        
        // Dismiss parent modal / navigation view
        modalMode.wrappedValue.toggle()
    }
}

struct NewJournalIntakeExposureView_Previews: PreviewProvider {
    static var previews: some View {
        NewJournalIEPView(.foodIntake, viewModel: JournalInputViewModel(.child, mode: .onboarding))
        NewJournalIEPView(.exposure, viewModel: JournalInputViewModel(.child, mode: .onboarding))
    }
}
