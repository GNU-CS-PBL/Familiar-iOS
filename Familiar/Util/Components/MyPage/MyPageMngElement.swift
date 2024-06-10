//
//  MyPageMngElement.swift
//  Familiar
//
//  Created by 준호 on 6/4/24.
//

import SwiftUI

struct MyPageMngElement<Content: View>: View {
    let content: Content
    let menuTitle: String
    let invtNum: Int
    
    init(menuTitle: String, invtNum: Int, @ViewBuilder content: () -> Content) {
        self.menuTitle = menuTitle
        self.invtNum = invtNum
        self.content = content()
    }
    
    var body: some View {
        NavigationLink(
            destination: content
                .navigationTitle(menuTitle)
        ) {
            HStack(alignment: .center, spacing: 8) {
                Text(menuTitle)
                    .font(
                        Font.custom("Pretendard-Regular", size: 16)
//                            .weight(.medium)
                    )
                    .foregroundColor(Color.grayScale900)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                HStack(alignment: .top, spacing: 8) {
                    Text(String(invtNum))
                        .font(
                            Font.custom("Pretendard", size: 11)
                                .weight(.medium)
                        )
                        .kerning(0.25)
                        .foregroundColor(Color.main400)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.grayScale100)
                .cornerRadius(16)
                
                Image("chevron-forward")
                    .frame(width: 20, height: 20)
            }
            .padding(16)
            .frame(width: .infinity, height: 56, alignment: .leading)
            .background(Color.white)
        }
    }
}
