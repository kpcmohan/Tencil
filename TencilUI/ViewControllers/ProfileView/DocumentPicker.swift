//
//  DocumentPicker.swift
//  TencilUI
//
//  Created by Chandra Mohan on 30/09/21.
//

import SwiftUI
import Alamofire
import Foundation
import Photos
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @State var image : Bool
    @Binding var selectedImage : UIImage?
    var sourceType: UIImagePickerController.SourceType =  .photoLibrary
    @Binding var selectedVideoData : Data?
    @Binding var isUploading : Bool?
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = image ? ["public.image"] : ["public.movie"]
        return imagePicker
}

func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    
}

func makeCoordinator() -> Coordinator {
    Coordinator(self)
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ parent: ImagePicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoURL = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerReferenceURL") ] as? NSURL{
            
            self.parent.isUploading = true
            self.parent.selectedVideoData = videoURL.dataRepresentation
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
        }
        self.parent.presentationMode.wrappedValue.dismiss()
        
    }
}
}
