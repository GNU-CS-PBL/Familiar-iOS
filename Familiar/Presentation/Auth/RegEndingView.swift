//
//  RegEndingView.swift
//  Familiars
//
//  Created by 준호 on 3/16/24.
//

import SwiftUI

// MARK: - State
struct RegEndingView: View {
    var nickname: String
    
    let topPadding: CGFloat = Constants.Paddings.regTop
    let BottomPadding: CGFloat = Constants.Paddings.regBottom
    let horizontalPadding: CGFloat = Constants.Paddings.regHorizontal
    
    @Environment(\.dismiss) var dismiss
    @State private var shouldNavigateToRoomView = false

    var body: some View {
        VStack(spacing: 24) {
            icon
                .padding(.top, 120)
            explnBody
            Spacer()
            startButton
        }
        .padding(.top, topPadding)
        .padding(.bottom, BottomPadding)
        .padding(.horizontal, horizontalPadding)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $shouldNavigateToRoomView) {
            RoomView()
        }
    }
}

// MARK: - View Detail
extension RegEndingView {
    private var icon: some View {
        Image("popper")
            .resizable()
            .frame(width: 40, height: 40)
    }
    
    private var explnBody: some View {
        VStack(spacing: 12) {
            Text("\(nickname)님\n환영합니다!")
                .font(Font.custom("Pretendard-Medium", size: 24))
                .multilineTextAlignment(.center)
            
            Text("방에 가입하여 구성원들과 함께\n활동을 진행해 보세요!")
                .foregroundColor(.secondary)
                .font(Font.custom("Pretendard-Regular", size: 16))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private var startButton: some View {
        Button(action: {
            UserDefaults.standard.set(false, forKey: "isRoomJoin")
            shouldNavigateToRoomView = true
        }) {
            Text("시작하기")
        }
        .buttonStyle(StandardButtonStyle())
    }
}

// MARK: - Preview
struct RegEndingView_Previews: PreviewProvider {
    static var previews: some View {
        RegEndingView(nickname: "테스터")
    }
}
