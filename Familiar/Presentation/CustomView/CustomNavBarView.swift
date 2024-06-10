//
//  CustomNavBarView.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

// MARK: - 1. 기본
struct CustomNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    
    var body: some View {
        HStack(alignment: .center) {
            if (showBackButton) {
                backButton // 뒤로가기
            }
            Spacer()
            titleSection // 타이틀 영역
                .padding(.trailing, 38)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
        .frame(width: UIScreen.main.bounds.width, height: 58, alignment: .leading)
    }
}
extension CustomNavBarView {
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("navi-back")
                .frame(width: 38, height: 38)
        }
    }
    private var titleSection: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(
                    Font.custom("Pretendard", size: 17)
                        .weight(.semibold)
                )
        }
    }
}
