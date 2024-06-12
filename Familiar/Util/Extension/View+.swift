//
//  View+.swift
//  Familiar
//
//  Created by 박예진 on 6/12/24.
//

import SwiftUI

// alert custom view
extension View {
    func customAlertView(isPresented: Binding<Bool>,
                         title: String,
                         titleColor: Color = .main400,
                         description: String,
                         primary: AlertAction,
                         secondary: AlertAction? = nil) -> some View {
        UIView.setAnimationsEnabled(false)
        return self
            .fullScreenCover(isPresented: isPresented) {
                AlertView(title: title,
                          titleColor: titleColor,
                          description: description,
                          primary: primary
                    .appendAction {
                        isPresented.wrappedValue.toggle()
                    },
                          secondary: secondary?
                    .appendAction {
                        isPresented.wrappedValue.toggle()
                    })
                .presentationBackground(.clear)
            }
    }
}

