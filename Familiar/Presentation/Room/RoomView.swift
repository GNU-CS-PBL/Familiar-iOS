//
//  RoomView.swift
//  Familiar
//
//  Created by 준호 on 6/15/24.
//

import SwiftUI

struct RoomView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 73) {
                explnTitle
                roomSelectButton
                Spacer()
            }
        }
    }
}

extension RoomView {
    private var explnTitle: some View {
        VStack(spacing: 12) {
            HStack {
                Text("방을 가입 또는 생성해 보세요!")
                    .font(
                        Font.custom("Pretendard", size: 24)
                            .weight(.bold)
                    )
                    .foregroundColor(Color.grayScale900)
                Spacer()
            }
            HStack {
                Text("구성원들과 함께 일정을 공유하고, 추억도 쌓을 수 있습니다.")
                    .font(Font.custom("Pretendard", size: 16))
                    .foregroundColor(Color.grayScale400)
                Spacer()
            }
        }
        .padding(.top, 72)
        .padding(.leading, 24)
    }
    
    private var roomSelectButton: some View {
        HStack(spacing: 16) {
            CustomNavLink(destination: RegRoomNameView()
            ) {
                VStack(spacing: 16){
                    ///이미지
                    Image("room")
                    Text("방 생성")
                        .font(
                            Font.custom("Pretendard-Bold", size: 22)
                                .weight(.bold)
                        )
                        .foregroundColor(Color.grayScale800)
                }
            }
            .frame(width: 163, height: 190)/// 변경 필요
            .background(.white)
            .cornerRadius(6)
            .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
            
            NavigationLink(destination: RegRoomNameView()
            ) {
                VStack(spacing: 16){
                    ///이미지
                    Image("room")
                    Text("방 가입")
                        .font(
                            Font.custom("Pretendard-Bold", size: 22)
                                .weight(.bold)
                        )
                        .foregroundColor(Color.grayScale800)
                }
            }
            .frame(width: 163, height: 190)/// 변경 필요
            .background(.white)
            .cornerRadius(6)
            .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    RoomView()
}
