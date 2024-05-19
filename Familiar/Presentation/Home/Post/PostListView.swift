//
//  PostListView.swift
//  practice
//
//  Created by 박예진 on 3/15/24.
//

import SwiftUI

struct PostListView: View {
    
    @State var userProfileImage: UIImage = UIImage(named: "cat")!
    @State var userNickName : String = "고먐미"
    @State var createdTime: String = "7시간 전"
    @State var pressPinButton : Bool = false
    @State var pressShowMoreButton : Bool = false
    @State var pressGreatButton : Bool = false
    @State var pressComentButton : Bool = false
    @State var resultActionSheet : String = ""
    @State var great: Int = 7
    @State var comment: Int = 10
    @State var isShowMenu: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                HStack (spacing:0) {
                    
                    Image(uiImage: userProfileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width:40, height: 40)
                        .cornerRadius(20)
                    
                    Text(userNickName)
                        .font(.system(size: 20))
                        .padding(.leading, 16)
                    
                    Text(createdTime)
                        .font(.system(size: 18))
                        .padding(.leading, 10)
                        .foregroundColor(Constants.Colors.grayScale500)
                    
                    Spacer()
                    
//                    // 게시물 고정 버튼
//                    Button {
//                        pressPinButton.toggle()
//                    } label: {
//                        Image(pressPinButton ? "pin.fill" : "pin")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width:24, height: 24)
//                    }
//                    .padding(.trailing, 16)
//
                    // 더보기 버튼
                    
                    Button {
                        isShowMenu = true
                    } label: {
                        Image("showMore")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                    }
                } // : HStack
                
                // 게시글 내용
                Text("제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다.제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다.")
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 14)
                
                // 좋아요 버튼
                HStack {
                    Spacer()
                    Button {
                        pressGreatButton.toggle()
                        self.great += pressGreatButton ? 1 : -1
                    } label: {
                        Image(pressGreatButton ? "great.fill" : "great")
                            .resizable()
                            .scaledToFill()
                            .frame(width:25, height: 25)
                    }
                    Text("\(great)")
                        .font(.system(size: 15))
                        .foregroundColor(Constants.Colors.grayScale600)
                    Spacer()
                    
                    // 구분선 크기조절
                    Divider()
                        .frame(height: 40)
                    
                    // 댓글 버튼
                    
                    Spacer()
                    Button {
                        pressComentButton.toggle()
                    } label: {
                        Image("coment")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                    }
                    .sheet(isPresented: $pressComentButton) {
                        if #available(iOS 16.4, *) {
                            ComentSheetView()
                                .presentationDetents([.medium])
                                .presentationCornerRadius(25)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    Text("\(comment)")
                        .font(.system(size: 15))
                        .foregroundColor(Constants.Colors.grayScale600)
                    Spacer()
                }
                .padding(.vertical, 10)
                
                Divider()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .onTapGesture {
                self.isShowMenu = false
            }
            if(isShowMenu) {
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
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Constants.Colors.grayScale400, lineWidth: 1)
                )
                .padding(.trailing, 10)
            }
        }
        
    } // : body
}

#Preview {
    PostListView()
}
