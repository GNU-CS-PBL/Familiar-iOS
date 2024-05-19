//
//  ComentSheet.swift
//  practice
//
//  Created by 박예진 on 3/15/24.
//

import SwiftUI

struct ComentListView: View {
    
    @Binding var userProfileImage : UIImage
    @Binding var userNickName : String
    @State var pressShowMoreButton : Bool = false
    @State var isShowMenu: Bool = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack(spacing: 0) {
                HStack (alignment: .top, spacing: 0) {
                    Image(uiImage: userProfileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                       
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            Text(userNickName)
                                .font(.system(size: 20, weight: .medium))
                            Text("7시간 전")
                                .font(.system(size: 18))
                                .foregroundColor(Constants.Colors.grayScale500)
                                .padding(.leading, 8)
                        }
                        .padding(.bottom, 10)
                        
                        Text("댓글입니다.")
                            .font(.system(size: 18))
                            .frame(width: .infinity, alignment: .leading)
                    }
                    .padding(.leading, 24)
                    .padding(.top, 8)
                    
                    Spacer()
                    
//                    // 더보기 버튼
//
//                    Button {
//                        isShowMenu = true
//                    } label: {
//                        Image("showMore")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 25, height: 25)
//                            .padding(.top, 15)
//                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            if isShowMenu {
                VStack(spacing: 0) {
                    Button {
                        isShowMenu = false
                    } label: {
                        Text("수정하기")
                    }
                    .padding(.vertical, 8)
                    Constants.Colors.grayScale400
                        .frame(width: 100, height: 1)
                    Button {
                        isShowMenu = false
                    } label: {
                        Text("삭제")
                    }
                    .padding(.vertical, 8)
                }
                .frame(width: 100)
                .background(.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Constants.Colors.grayScale400, lineWidth: 1)
                )
                .padding(.trailing, 10)
            }
        }
    }
}

#Preview {
    ComentListView(userProfileImage: .constant(UIImage(named: "cat")!), userNickName: .constant("해피"))
}
