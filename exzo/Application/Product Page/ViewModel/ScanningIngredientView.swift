//
//  ScanIngredientView.swift
//  VisionTut
//
//  Created by Difa N Pratama on 01/11/21.
//

import SwiftUI
import VisionKit
import Vision

class ContentViewModel: ObservableObject {
    @Published var showVision = false
    @Published var arrayString = [String]()
}

struct ScanIngredientView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedText: [String]
    @Binding var scanDone: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, parent: self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        // nothing to do here
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var recognizedText: Binding<[String]>
        var parent: ScanIngredientView
        
        init(recognizedText: Binding<[String]>, parent: ScanIngredientView) {
            self.recognizedText = recognizedText
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let extractedImages = extractImages(from: scan)
            let processedText = recognizeText(from: extractedImages)
            let separateProcess = processedText.components(separatedBy: ", ")
            recognizedText.wrappedValue = separateProcess
            
            parent.scanDone.toggle()
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        fileprivate func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
            var extractedImages = [CGImage]()
            for index in 0..<scan.pageCount {
                let extractedImage = scan.imageOfPage(at: index)
                guard let cgImage = extractedImage.cgImage else { continue }
                
                extractedImages.append(cgImage)
            }
            return extractedImages
        }
        
        fileprivate func recognizeText(from images: [CGImage]) -> String {
            var entireRecognizedText = ""
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else { return }
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                let maximumRecognitionCandidates = 1
                for observation in observations {
                    guard let candidate = observation.topCandidates(maximumRecognitionCandidates).first else { continue }
                    
                    entireRecognizedText += "-\(candidate.string)\n"
                                        
                }
            }
            recognizeTextRequest.recognitionLevel = .accurate
            
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                
                try? requestHandler.perform([recognizeTextRequest])
            }
            
            return entireRecognizedText
        }
    }
}

public func checkAvoid(name: [String]) -> [String] {
    var newArr: [String] = []
    for index in name {
        for igr in bahanBerbahya {
            let kandungan = igr.bahanMengandung.map { string -> String in
                return string.lowercased()
            }
            if kandungan.contains(index.lowercased()) {
                if !newArr.contains(igr.name) {
                    newArr.append(igr.name)
                }
            }
        }
    }
    return newArr
}

public let avoidIng = ["dyes",
                       "fragrance",
                       "ethanol",
                       "preservatives",
                       "propylene glycol",
                       "urea",
                       "retinoid",
                       "antibiotics",
                       "formaldehyde",
                       "paraben"

]
