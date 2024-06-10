//
//  CustomNavLink.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    @Binding var isActive: Bool?
    
    init(destination: Destination,
         @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        _isActive = Binding.constant(nil)
    }
    
    init(destination: Destination,
         isActive: Binding<Bool>,
         @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        _isActive = isActive.optionalBinding
    }
    
    var body: some View {
            if let isActive = isActive {
                NavigationLink(destination: CustomNavBarContainerView {
                    destination
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }, isActive: Binding(get: { isActive == true }, set: { self.isActive = $0 ? true : nil })) {
                    label
                }
            } else {
                NavigationLink(destination: CustomNavBarContainerView {
                    destination
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }) {
                    label
                }
            }
            
        
     
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

extension Binding where Value == Bool {
    var optionalBinding: Binding<Bool?> {
        Binding<Bool?>(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue ?? false
            }
        )
    }
}
