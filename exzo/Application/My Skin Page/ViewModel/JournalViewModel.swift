//
//  MySkinViewModel.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import Foundation
import Combine
import UIKit

class JournalViewModel: ObservableObject {
    var journalModel = CDStorage.shared
    
    @Published var journals = [Journal]()
    
    private var cancellable: AnyCancellable?

    init(
        journalPublisher: AnyPublisher<[Journal], Never> = CDStorage.shared.journalItems.eraseToAnyPublisher()
    ) {
        cancellable = journalPublisher.sink { journalItem in
            print("update journal")
            self.journals = journalItem
            print(self.journals)
        }
    }
}

//class ProductViewModel: ObservableObject {
//    var productModel = CDStorage.shared
//
//    @Published var products: [Product] = []
//
//    private var cancellable: AnyCancellable?
//
//    init(
//        productPublisher: AnyPublisher<[Product], Never> = CDStorage.shared.productItems.eraseToAnyPublisher()
//    ) {
//        cancellable = productPublisher.sink { productItems in
//            print("update product")
//            self.products = productItems
//        }
//    }
//
//    func addNewItem(name: String, type: ProductType, image: UIImage? = nil) {
//        productModel.createProduct(name: name, type: type, image: image)
//    }
//
//    func deleteItem(index offset: IndexSet) {
//        offset.map {
//            guard let id = products[$0].idProduct else { return }
//            productModel.deleteProduct(with: id)
//        }
//    }
//}
