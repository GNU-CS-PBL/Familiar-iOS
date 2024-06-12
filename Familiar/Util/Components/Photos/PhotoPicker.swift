import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    var singleSelection: Binding<UIImage?>?
    var multipleSelection: Binding<[UIImage]>?
    
    var isErrorAlertPresented: Binding<Bool>?
    
    init(selection: Binding<UIImage?>, isErrorAlertPresented: Binding<Bool>? = nil) {
        self.singleSelection = selection
        self.multipleSelection = nil
        self.isErrorAlertPresented = isErrorAlertPresented
    }
    
    init(selection: Binding<[UIImage]>, isErrorAlertPresented: Binding<Bool>? = nil) {
        self.singleSelection = nil
        self.multipleSelection = selection
        self.isErrorAlertPresented = isErrorAlertPresented
    }
    
    func makeCoordinator() -> PhotoPickerCoordinator {
        PhotoPickerCoordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = singleSelection == nil ? 4 : 1
        configuration.filter = .images
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
}
