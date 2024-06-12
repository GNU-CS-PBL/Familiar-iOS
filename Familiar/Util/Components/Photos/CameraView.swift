//
//  CameraView.swift
//  Familiar
//
//  Created by 박예진 on 6/13/24.
//

import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    
    @Binding var selection: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> CameraCoordinator {
        return CameraCoordinator(picker: self)
    }
}

