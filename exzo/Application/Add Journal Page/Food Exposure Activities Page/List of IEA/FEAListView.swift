//
//  FEAListView.swift
//  exzo
//
//  Created by Deven Nathanael on 10/11/21.
//

import SwiftUI
import Combine

class FEAListViewModel: ObservableObject {
    @Published var feaItems = [CategoryItem]()
    
    private var cancellable: AnyCancellable?
    var cat: IEA
    
    @Published var alertCantDelete = false
    
    init(category: IEA) {
        self.cat = category
        switch category {
        case .intake:
            cancellable = CDStorage.shared.foodIntakes.eraseToAnyPublisher().sink { items in
                self.feaItems = items.map { item in
                    // Selected disini adalah is favorite or not
                    guard let id = item.idFoodIntake,
                          let icon = item.intakeThumb,
                          let name = item.intakeName
                    else { return CategoryItem(iconName: "", name: "", selected: false)}
                    return CategoryItem(id: id, iconName: icon, name: name, selected: item.isFavorite, deletable: item.deletable)
                }
            }
        case .exposure:
            cancellable = CDStorage.shared.envExposures.eraseToAnyPublisher().sink { items in
                self.feaItems = items.map { item in
                    // Selected disini adalah is favorite or not
                    guard let id = item.idExposure,
                          let icon = item.exposureThumb,
                          let name = item.exposureName
                    else { return CategoryItem(iconName: "", name: "", selected: false)}
                    return CategoryItem(id: id, iconName: icon, name: name, selected: item.isFavorite, deletable: item.deletable)
                }
            }
        case .activity:
            cancellable = CDStorage.shared.activities.eraseToAnyPublisher().sink { items in
                self.feaItems = items.map { item in
                    // Selected disini adalah is favorite or not
                    guard let id = item.idActivity,
                          let icon = item.activityThumb,
                          let name = item.activityName
                    else { return CategoryItem(iconName: "", name: "", selected: false)}
                    return CategoryItem(id: id, iconName: icon, name: name, selected: item.isFavorite, deletable: item.deletable)
                }
            }
        }
    }
    
    func setFavorite(id: UUID) {
        CDStorage.shared.updateFavoriteIEA(cat, id: id)
    }
    
    func deleteCategory(item: CategoryItem) {
        guard let deletable = item.deletable else { return }
        if deletable {
            CDStorage.shared.deleteIEA(self.cat, id: item.id)
        } else {
            self.alertCantDelete.toggle()
        }
    }
}

struct FEAListView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: FEAListViewModel
    var title: String = "Nav Title"
    var accent: String = "accent_yellow"
    
    init(ieaCategory: IEA) {
        viewModel = FEAListViewModel(category: ieaCategory)
        switch ieaCategory {
        case .intake:
            title = "Food Intake"
            accent = "accent_yellow"
        case .exposure:
            title = "Exposure"
            accent = "accent_copper"
        case .activity:
            title = "Activities"
            accent = "accent_brandy"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.feaItems) { itm in
                        FEAListRowView(name: itm.name, image: itm.iconName, favorite: itm.selected, color: accent)
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button(role: .none) {
                                    viewModel.setFavorite(id: itm.id)
                                } label: {
                                    Image(systemName: itm.selected ? "star.slash" : "star")
                                    Text("Favorite")
                                }
                                .tint(.yellow)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    // Action to delete
                                    viewModel.deleteCategory(item: itm)
                                } label: {
                                    Image(systemName: "trash")
                                    Text("Delete")
                                }
                            }
                    }
                }
                .alert("Can't delete item", isPresented: $viewModel.alertCantDelete) {
                    Button("OK", role: .cancel) {
                        print("Cancel")
                    }
                } message: {
                    Text("This item is a available by default and it is undeletable")
                }

                Section {
                    NavigationLink {
                        AddFEAView(category: viewModel.cat, accent: Color(accent))
                    } label: {
                        Image(systemName: "plus")
                        Text("Add new \(title)")
                    }
                    .multilineTextAlignment(.center)
                    .buttonStyle(PlainButtonStyle())
                    .padding(0)
                    .foregroundColor(.white)
                }
                .listRowBackground(Color.brandy)
                .background(Color.clear)
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: dismiss.callAsFunction)
                }
            }
        }
        
    }
}

struct FEAListView_Previews: PreviewProvider {
    static var previews: some View {
        FEAListView(ieaCategory: .intake)
    }
}
