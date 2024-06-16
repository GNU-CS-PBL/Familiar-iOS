//
//  StdTextFieldStyle.swift
//  Familiar
//
//  Created by 준호 on 3/16/24.
//

import SwiftUI

// MARK: - TextFieldStyle
struct StdTextFieldStyle: TextFieldStyle {
    var placeholder: String
    var placeholderImage: String?
    var isFocused: Bool
    var isActive: Bool

    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(alignment: .center, spacing: 6) {
            configuration
                .font(Font.custom("Pretendard-Regular", size: 18))
                .foregroundColor(Constants.Colors.grayScale500)
            
            Spacer()
            if let placeholderImage = placeholderImage {
                Image(placeholderImage)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 8)
        .frame(height: 46, alignment: .leading)
        .background(.white)
        .overlay(
            Rectangle()
                .inset(by: 0.5)
                .offset(y: 18)
                .stroke(isActive || isFocused ? Constants.Colors.main300 : Constants.Colors.grayScale300, lineWidth: 1)
                .frame(height: 2)
        )

        .accentColor(Constants.Colors.main300)
    }
}

// MARK: - Preview
struct StdTextFieldStyle_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var text: String = ""
        @FocusState private var isTextFieldFocused: Bool
        
        var body: some View {
            VStack {
                // 활성화 상태
                TextField("활성화 상태", text: $text)
                    .textFieldStyle(StdTextFieldStyle(placeholder: "활성화 상태", placeholderImage: "pencil", isFocused: isTextFieldFocused , isActive: !text.isEmpty))
                    .padding()
                
                // 비활성화 상태
                TextField("비활성화 상태", text: $text)
                    .textFieldStyle(StdTextFieldStyle(placeholder: "비활성화 상태", placeholderImage: "pencil", isFocused: isTextFieldFocused, isActive: false))
                    .padding()
            }
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
            .previewLayout(.sizeThatFits)
    }
}
