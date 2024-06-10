//
//  StdTextField.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

struct StdTextField: View {
    @Binding var text: String
    var maxLength: Int?
    var placeholder: String
    
    @State private var isFocused: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            TextField(placeholder, text: $text, onEditingChanged: { isEditing in
                self.isFocused = isEditing
            })
            .onChange(of: text) { newValue in
                if let maxLength = maxLength, newValue.count > maxLength {
                    text = String(newValue.prefix(maxLength))
                }
            }
            .font(Font.custom("Pretendard-Regular", size: 18))
            .foregroundColor(Color.grayScale900)
            
            Spacer()
            
            if let maxLength = maxLength {
                Text("\(text.count)/\(maxLength)")
                    .foregroundColor(Color.grayScale400)
            }
            
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image("close-circle")
                        .foregroundColor(Color.grayScale500)
                }
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 8)
        .frame(height: 46, alignment: .leading)
        .background(Color.white)
        .overlay(
            Rectangle()
                .inset(by: 0.5)
                .offset(y: 18)
                .stroke(isFocused ? Color.main300 : Color.grayScale300, lineWidth: 1)
                .frame(height: 2)
        )
        .accentColor(Color.main300)
        .onTapGesture {
            self.isFocused = true
        }
    }
}
