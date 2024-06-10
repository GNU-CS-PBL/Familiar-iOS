//
//  MyPageElement.swift
//  Familiar
//
//  Created by 준호 on 6/4/24.
//

import SwiftUI

struct MyPageElementView<Content: View>: View {
    let content: Content
    let menuTitle: String
    let emphs: Bool
    
    init(menuTitle: String, emphs: Bool, @ViewBuilder content: () -> Content) {
        self.menuTitle = menuTitle
        self.content = content()
        self.emphs = emphs
    }
    
    var body: some View {
        CustomNavLink(
            destination: content
                .customNavigationTitle(menuTitle)
        ) {
            HStack(alignment: .center, spacing: 8) {
                Text(menuTitle)
                    .font(
                        Font.custom("Pretendard-Regular", size: 16)
//                            .weight(.medium)
                    )
                    .foregroundColor(emphs ? Color(red: 0.99, green: 0.28, blue: 0.28).opacity(0.9) : Color(red: 0.12, green: 0.13, blue: 0.13))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Image("chevron-forward")
                    .frame(width: 20, height: 20)
            }
            .padding(16)
            .frame(width: .infinity, height: 56, alignment: .leading)
            .background(Color.white)
        }
    }
}
