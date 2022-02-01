//
//  OCRVision.swift
//  exzo
//
//  Created by Difa N Pratama on 24/01/22.
//

import SwiftUI
import Vision

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
