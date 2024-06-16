//
//  AdView.swift
//  Familiar
//
//  Created by 준호 on 6/16/24.
//

import SwiftUI

struct AdView: View {
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 24) {
                    
                    HStack {
                        Text("가족과 함께\n추억을 쌓을 장소들..!")
                            .font(Font.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    
                    HStack(spacing: 2) {
                        Text("보러가기")
                            .font(
                                Font.custom("Pretendard-Medium", size: 12)
                            )
                            .kerning(0.25)
                            .foregroundColor(.white)
                        
                        Image("chevron-forward")
                            .frame(width: 16, height: 16)
                    }
                }
                Spacer()
                
                HStack {
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 75.32037, height: 75.32037)
                    .background(
                    Image("map-pin")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 83.12055, height: 83.12055)
                    .clipped()
                    )
                    .shadow(color: .black.opacity(0.1), radius: 6.5, x: 0, y: 12)
                    .rotationEffect(Angle(degrees: 5.21))
                }
            }
        }.padding()
        .frame(height: 118)
        .background(Color.main200)
        .cornerRadius(6)
        .shadow(color: Color.main400, radius: 3, x: 0, y: 5)
    }
}

struct AdView_Previews: PreviewProvider {
    static var previews: some View {
        AdView()
    }
}
