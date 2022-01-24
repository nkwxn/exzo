//
//  ProductViewModel.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import Foundation
import Combine
import UIKit
import Vision

class ProductViewModel: ObservableObject {
    var productModel = CDStorage.shared
    
    @Published var products: [Product] = []
    
    private var cancellable: AnyCancellable?
    
    init(
        productPublisher: AnyPublisher<[Product], Never> = CDStorage.shared.productItems.eraseToAnyPublisher()
    ) {
        cancellable = productPublisher.sink { productItems in
            print("update product")
            self.products = productItems
        }
    }
    
    func addNewItem(name: String, type: ProductType, image: UIImage? = nil, ingredient: [String]) {
        productModel.createProduct(name: name, type: type, image: image, ingredients: ingredient)
    }
    
    func deleteItem(index offset: IndexSet) {
        offset.map {
            guard let id = products[$0].idProduct else { return }
            productModel.deleteProduct(with: id)
        }
    }
    
    func deleteItem(id: UUID) {
        productModel.deleteProduct(with: id)
    }
}

public func recognizeText( image: UIImage?, text: String) {
    guard let cgImage = image?.cgImage else {return}
    var recg = text
    // Handler
    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    
    // Request
    let request = VNRecognizeTextRequest { request, error in
         print(request.results) // to check result
        guard let observations = request.results as? [VNRecognizedTextObservation],
              error == nil else {
                  // check if nil
                  return
              }
        let text = observations.compactMap({
            $0.topCandidates(1).first?.string
        })
        
        let avoid = ["Ethanol", "Acne", "Fragrance"]
        DispatchQueue.main.async {
            for item in text {
                for index in avoid {
                    if item.contains(index) {
                        recg += item.lowercased() + " , "
                    }
                }
                            
            }
            
        }
    }
    
    // Process request
    do {
        try handler.perform([request])
    }
    catch{
        print(error)
    }
}
