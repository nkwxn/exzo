//
//  TriggerAreas.swift
//  exzo
//
//  Created by Nicholas on 10/11/21.
//

import SwiftUI

struct TriggerAreaItem {
    var name: String
    var image: UIImage?
    
    func safeImage() -> UIImage {
        guard let image = image else {
            return UIImage()
        }
        return image
    }
}

struct TriggerAreaHScroll: View {
    @Binding var items: [TriggerAreaItem]
    @State var showOption = false
    @State var showPhotoGalery = false
    @State var showCamera = false
    
    var body: some View {
        if items.isEmpty {
            VStack {
                Text("Trigger area is empty")
                    .font(Lexend(.title).getFont())
            }
        } else {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(items.enumerated()), id: \.0) { idx, _ in
                        TriggerItemView(item: $items[idx])
                            .frame(width: 150, height: 230, alignment: .center)
                    }
                }
            }
        }
    }
}

struct TriggerItemView: View {
    @Binding var item: TriggerAreaItem
    @State var showOption = false
    @State var showPhotoGalery = false
    @State var showCamera = false
    
    var body: some View {
        VStack {
            if item.image != nil {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: item.safeImage())
                        .resizable()
                        .background(Color.clear)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, alignment: .center)
                        .cornerRadius(15)
                        .clipped()
                    Button {
                        // Remove image
                        self.item.image = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .padding(8)
                    .foregroundColor(Color.white)
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.copper, lineWidth: 2)
                        .foregroundColor(Color.clear)
                    VStack {
                        Image(systemName: "camera")
                        Text("Photo")
                    }
                    .foregroundColor(Color.copper)
                }
            }
            Text(item.name)
        }
        .onTapGesture {
            self.showOption.toggle()
        }
        .confirmationDialog("Choose photo source", isPresented: $showOption, titleVisibility: .visible) {
            Button("Photo Library") {
                showPhotoGalery = true
            }
            Button("Camera") {
                showCamera = true
            }
        }
        .sheet(isPresented: $showPhotoGalery) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $item.image)
        }
        .fullScreenCover(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera, selectedImage: $item.image)
        }
    }
}

struct ItemPreview: PreviewProvider {
    static var previews: some View {
        TriggerItemView(item: .constant(TriggerAreaItem(name: "Right Arm", image: UIImage(named: "login_image"))))
            .frame(width: 150, height: 230, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}
