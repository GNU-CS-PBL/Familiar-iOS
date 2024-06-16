//
//  RegExplnTitle.swift
//  Familiar
//
//  Created by 준호 on 3/16/24.
//

import SwiftUI

struct RegExplnTitle: View {
    let mainText: String
    let subText: String?
    
    init(mainText: String, subText: String? = nil) {
        self.mainText = mainText
        self.subText = subText
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(mainText)
                    .font(Font.custom("Pretendard-Semibold", size: 24))
                    .foregroundColor(Constants.Colors.grayScale900)
                    .fixedSize(horizontal: false, vertical: true) // 키보드가 올라와도 크기 그대로 유지..!!
                Spacer()
            }
            if let subText = subText { /// SubText가 필요한 경우에만 표시
                HStack {
                    Text(subText)
                        .font(Font.custom("Pretendard-Regular", size: 16))
                        .foregroundColor(Constants.Colors.grayScale400)
                        .fixedSize(horizontal: false, vertical: true) // 키보드가 올라와도 크기 그대로 유지..!!
                    Spacer()
                }
            }
        }
    }
}
