//
//  CameraCoordinator.swift
//  Familiar
//
//  Created by 박예진 on 6/13/24.
//

import SwiftUI

class CameraCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: CameraView
    
    init(picker: CameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selection = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}


