//
//  RegRoomEndingView.swift
//  Familiar
//
//  Created by 준호 on 6/15/24.
//

import SwiftUI

struct RegRoomEndingView: View {
    var roomName: String

    @Environment(\.dismiss) var dismiss
    @State private var shouldNavigateToContentView = false

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("popper")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.top, 100) // 수정 필요
            
            Text("\(roomName)\n방 생성을\n축하드립니다!")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Text("구성원들과 함께 \n 활동을 진행해 보세요!").foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            VStack {
                ZStack {
                    Button(action: {
                        UserDefaults.standard.set(true, forKey: "isRoomJoin")
                        shouldNavigateToContentView = true
                    }) {
                        Text("시작하기")
                            .font(.headline).bold()
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .foregroundColor(.white)
                            .background(Color.main300)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 42) // 수정 필요
                }
            }
        }
        .padding(.all)
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $shouldNavigateToContentView) {
            ContentView()
        }
    }
}

struct RegRoomEndingView_Previews: PreviewProvider {
    static var previews: some View {
        RegRoomEndingView(roomName: "행복한 우리 집")
    }
}
