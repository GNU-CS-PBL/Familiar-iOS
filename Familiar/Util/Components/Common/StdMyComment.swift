//
//  StdMyComment.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

struct StdMyComment {
    var Id: String = "123"
    var image: UIImage?
    var alias: String
    var comment: String
    @State var isShowMenu: Bool = false
}

extension StdMyComment: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 0) {
                profileImage
                    .padding(.trailing, 16)
                commentBody
                    .padding(.trailing, 4)
                Spacer()
                commentMenu
            }
            .frame(maxWidth: .infinity, maxHeight: 118)
            
            // 외부영역 클릭 시 메뉴 닫기
            .onReceive(NotificationCenter.default.publisher(for: .viewTapNotification)) { _ in
                isShowMenu = false
            }
            
            if(isShowMenu) {
                VStack(spacing: 0) {
                    Button {
                        isShowMenu = false
                    } label: {
                        Text("수정하기")
                            .font(.custom("pretendard", size: 14))
                    }
                    .padding(.vertical, 14)
                    Constants.Colors.grayScale400
                        .frame(width: 80, height: 1)
                    Button {
                        isShowMenu = false
                    } label: {
                        Text("삭제")
                            .font(.custom("pretendard", size: 14))
                    }
                    .padding(.vertical, 16)
                }
                .frame(width: 80)
                .background(.white)
                .cornerRadius(5)
                .foregroundColor(Constants.Colors.grayScale800)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Constants.Colors.grayScale200, lineWidth: 1)
                )
                .padding(.trailing, 10)
                .shadow(color: Color(red: 56/255, green: 29/255, blue: 22/255).opacity(0.1),
                        radius: 7, x: 0, y: 5)
            }
        }
        //        .onTapGesture {
        //            self.isShowMenu = false
        //        }
        //        if(isShowMenu) {
        //            VStack(spacing: 0) {
        //                Button {
        //                    isShowMenu = false
        //                } label: {
        //                    Text("수정하기")
        //                        .font(.custom("pretendard", size: 14))
        //                }
        //                .padding(.vertical, 14)
        //                Constants.Colors.grayScale400
        //                    .frame(width: 80, height: 1)
        //                Button {
        //                    isShowMenu = false
        //                } label: {
        //                    Text("삭제")
        //                        .font(.custom("pretendard", size: 14))
        //                }
        //                .padding(.vertical, 14)
        //            }
        //            .frame(width: 80)
        //            .background(.white)
        //            .cornerRadius(5)
        //            .foregroundColor(Constants.Colors.grayScale800)
        //            .overlay(
        //                RoundedRectangle(cornerRadius: 5)
        //                    .stroke(Constants.Colors.grayScale200, lineWidth: 1)
        //            )
        //            .padding(.trailing, 10)
        //            .shadow(color: Color(red: 56/255, green: 29/255, blue: 22/255).opacity(0.1),
        //                    radius: 7, x: 0, y: 5)
        //        }
    }
}

extension StdMyComment {
    private var profileImage: some View {
        VStack {
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
            Spacer()
        }
    }
    
    private var commentBody: some View {
        VStack(spacing: 4) {
            HStack {
                Text(alias)
                    .font(Font.custom("Pretendard-Semibold", size: 14))
                Spacer()
            }
            HStack {
                Text(comment)
                    .font(Font.custom("Pretendard-Regular", size: 14))
                    .lineLimit(5)
                Spacer()
            }
            Spacer()
        }
    }
    
    private var commentMenu: some View {
        VStack {
            Button {
                isShowMenu = true
            } label: {
                Image("showMore")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
            }
            Spacer()
        }
    }
}

#Preview {
    StdMyComment(alias: "고먐미", comment: "댓글은 최대 5줄입니다. 댓글은 최대 5줄입니다. 댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.")
}
