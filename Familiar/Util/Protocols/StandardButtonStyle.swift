//
//  StdButtonStyle.swift
//  Familiar
//
//  Created by 준호 on 3/16/24.
//

import SwiftUI

// MARK: - ButtonStyle
struct StandardButtonStyle: ButtonStyle {
    var labelColor = Color.white
    var backgroundColor = Constants.Colors.main200
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 56)
            .foregroundColor(labelColor)
            .background(backgroundColor)
            .font(.headline).bold()
            .cornerRadius(10)
    }
}
