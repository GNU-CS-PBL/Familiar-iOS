//
//  ErrorMessageText.swift
//  Familiar
//
//  Created by 준호 on 4/4/24.
//

import SwiftUI

struct ErrorMessageText: View {
    let errorMessage: String?
    
    init(errorMessage: String?) {
        self.errorMessage = errorMessage
    }
    
    var body: some View {
        HStack {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(Font.custom("Pretendard", size: 14).weight(.regular))
                    .foregroundColor(Constants.Colors.error)
                    .padding(.top, 4)
            }
            Spacer()
        }
    }
}
