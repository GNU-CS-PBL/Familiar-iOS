//
//  SplahView.swift
//  Familiar
//
//  Created by 박예진 on 5/29/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image("splash")
                .resizable()
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("가족들과\n함께 하는 \n문화를 만듭니다.")
                            .font(Font.custom("pretendard", size: 28).weight(.regular))
                            .foregroundColor(Constants.Colors.grayScale700)
                        
                        Text("패밀리어")
                            .font(Font.custom("Pretendard", size: 30).weight(.semibold))
                    }
                    .padding(.leading, 32)
                    .padding(.top, 128)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SplashView()
}
