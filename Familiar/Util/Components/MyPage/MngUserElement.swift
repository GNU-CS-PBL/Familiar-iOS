//
//  MngUserElement.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

// MARK: - State
struct MngUserElement {
    @State private var showMandateAlert: Bool = false
    @State private var showForcedExitAlert: Bool = false
    
    var id = "123"
    var image: UIImage?
    var nickname: String
    var mandateAction: (()->Void)? = nil // 위임 Action
    var forcedExitAction: (()->Void)? = nil // 강퇴 Action
    
    init(id: String = "123",
         image: UIImage? = nil,
         nickname: String,
         mandateAction: (() -> Void)? = nil,
         forcedExitAction: (() -> Void)? = nil) {
        self.id = id
        self.image = image
        self.nickname = nickname
        self.mandateAction = mandateAction
        self.forcedExitAction = forcedExitAction
    }
}

// MARK: - View
extension MngUserElement: View {
    var body: some View {
        HStack {
            userProfile
            Spacer()
            buttons
        }
        .frame(maxHeight: 68)
    }
}

// MARK: - View Detail
extension MngUserElement {
    private var userProfile: some View {
        HStack(spacing: 16) {
            if let displayImage = image {
                Image(uiImage: displayImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .clipShape(Circle())
            } else {
                Image("cat")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .clipShape(Circle())
            }
            
            Text(nickname)
                .font(Font.custom("Pretendard-Regular", size: 20))
        }
    }
    private var buttons: some View {
        HStack(spacing: 8) {
            Button(action: {
                showMandateAlert.toggle()
                /// api 통신
            }) {
                Text("위임")
                    .font(Font.custom("Pretendard-Regular", size: 16))
                    .foregroundColor(Color.main200)
                    .cornerRadius(5)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: 0.5)
                            .stroke(Color.main200, lineWidth: 1)
                    )
            }
            
            .customAlertView(isPresented: $showMandateAlert,
                             title: "위임",
                             description: "정말 해당 유저에게 반장을 \n위임 하시겠습니까?",
                             primary: AlertAction(text: "네",
                                                  foregroundColor: .main400,
                                                  action: {
                mandateAction?()
            }),
                             secondary: AlertAction(text: "아니오"))
            
            Button(action: {
                showForcedExitAlert.toggle()
                /// api 통신
            }) {
                Text("강퇴")
                    .font(Font.custom("Pretendard-Regular", size: 16))
                    .foregroundColor(Color.error)
                    .cornerRadius(5)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: 0.5)
                            .stroke(Color.error, lineWidth: 1)
                    )
            }
            
            .customAlertView(isPresented: $showForcedExitAlert,
                             title: "강퇴",
                             titleColor: .error,
                             description: "정말 해당 유저를 강퇴하시겠습니까?",
                             primary: AlertAction(text: "네",
                                                  foregroundColor: .main400,
                                                  action: {
                forcedExitAction?()
            }),
                             secondary: AlertAction(text: "아니오"))
        }
    }
}

// MARK: - Preview
#Preview {
    MngUserElement(nickname: "테스트")
}
