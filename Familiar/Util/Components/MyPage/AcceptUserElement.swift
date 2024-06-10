//
//  AcceptUserElement.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

// MARK: - State
struct AcceptUserElement {
    var id = "123"
    var image: UIImage?
    var nickname: String
}

// MARK: - View
extension AcceptUserElement: View {
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
extension AcceptUserElement {
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
                /// api 통신
            }) {
                Text("수락")
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
            
            Button(action: {
                /// api 통신
            }) {
                Text("거절")
                    .font(Font.custom("Pretendard-Regular", size: 16))
                    .foregroundColor(Color.grayScale500)
                    .cornerRadius(5)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(Color.grayScale500, lineWidth: 1)
                    )
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AcceptUserElement(nickname: "테스트")
}
