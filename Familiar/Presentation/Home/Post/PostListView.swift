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
    @State var tags: [String] = ["나", "냥냥이", "멍뭉이"]
    
    @State private var tagsHeight = CGFloat.zero
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 12) {
                HStack (spacing:0) {
                    Image(uiImage: userProfileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width:28, height: 28)
                        .cornerRadius(14)
                    
                    Text(userNickName)
                        .font(Font.custom("pretendard", size: 16))
                        .padding(.leading, 16)
                    
                    Text(createdTime)
                        .font(Font.custom("pretendard", size: 14))
                        .padding(.leading, 8)
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
                            .frame(width: 24, height: 24)
                    }
                } // : HStack
                
                VStack(spacing: 6){
                // 게시글 내용
                Text("제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다.제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다. 제한선은 5줄입니다.")
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
//                    .padding(.top, 14)
                    
                    // tags
                    VStack {
                        GeometryReader { geometry in
                            self.generateTags(in: geometry)
                        }
                    }
                    .frame(height: tagsHeight)
                }

                
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
                            .frame(width:22, height: 22)
                    }
                    Text("\(great)")
                        .font(.system(size: 15))
                        .foregroundColor(Constants.Colors.grayScale600)
                    Spacer()
                    
                    // 구분선 크기조절
                    Divider()
                        .frame(width: 1, height: 22)
                        .background(Constants.Colors.grayScale400)
                    
                    // 댓글 버튼
                    
                    Spacer()
                    Button {
                        pressComentButton.toggle()
                    } label: {
                        Image("coment")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 22, height: 22)
                    }
                    .sheet(isPresented: $pressComentButton) {
                        if #available(iOS 16.4, *) {
                            ComentSheetView(userProfileImage: $userProfileImage)
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
                .padding(.top, 6)
                .padding(.bottom, 14)
                
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
                    .padding(.vertical, 14)
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
        
    } // : body
    
    // 태그 정렬
    func generateTags(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tags, id: \.self) { tag in
                item(for: tag)
                    .padding(.trailing, 8)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($tagsHeight))
    }
    
    
    // 태그 문자열을 뷰로 변환
    func item(for tag: String) -> some View {
        Text("@\(tag)")
            .font(.system(size: 14))
            .foregroundColor(Constants.Colors.grayScale500)
    }
    
    // 뷰 높이 계산
    func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

#Preview {
    PostListView()
}
