//
//  MyContentMngView.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI


// MARK: - State
struct MyContentMngView {
    @State var buttonTabbed: Bool = false
    @State var contentTab: String = "게시물"
    
    @State var contentNum: Int = 3
}

// MARK: - View
extension MyContentMngView: View {
    var body: some View {
        VStack(spacing: 0) {
            contentSelectBar
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color.grayScale100)
            ScrollView {
                if (contentTab == "게시물") {
                    postContents
                } else {
                    commentContents
                }
            }
            .padding(.top, 8)
            Spacer()
        }
        
        .onTapGesture {
            NotificationCenter.default.post(
                name: .viewTapNotification,
                 object: nil,
                 userInfo: nil
               )
        }
    }
}

// MARK: - ViewDetail
extension MyContentMngView {
    private var contentSelectBar: some View {
        HStack(alignment: .center) {
            HStack(alignment: .top, spacing: 0) {
                /// 게시물
                Button(action: {
                    contentTab = "게시물"
                    buttonTabbed = false
                }){
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("게시물")
                                .font(Font.custom("Pretendard-medium", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(buttonTabbed ? Color.grayScale700 : Color.main200)
                            
                            Divider()
                                .frame(width: 41, height: 2)
                                .background(buttonTabbed ? Color.white : Color.main200)
                        }
                        .padding(0)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(0)
                .frame(width: 72, height: 44, alignment: .bottom)
                
                ///댓글
                Button(action: {
                    contentTab = "댓글"
                    buttonTabbed = true
                }) {
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("댓글")
                                .font(Font.custom("Pretendard", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(buttonTabbed ? Color.main200 : Color.grayScale700)
                            
                            Divider()
                                .frame(width: 41, height: 2)
                                .background(buttonTabbed ? Color.main200 : Color.white)
                        }
                        .padding(0)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(0)
                .frame(width: 72, height: 44, alignment: .bottom)
            }
            .padding(0)
            Spacer()
        }
    }
    
    private var postContents: some View {
        VStack(spacing: 0) {
            if contentNum > 0 {
                ForEach(1...contentNum, id: \.self) { count in
//                    PostListView()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            } else {
                NonContentView(title: contentTab)
            }
        }
    }
    
    private var commentContents: some View {
        VStack(spacing: 0) {
            if contentNum > 0 {
                ForEach(1...contentNum, id: \.self) { count in
                    StdMyComment(Id: "123", image: UIImage(named: "cat"), alias: "고먐미", comment: "댓글은 최대 5줄입니다. 댓글은 최대 5줄입니다. 댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.댓글은 최대 5줄입니다.")
                    if (count != contentNum) {
                        Rectangle()
                            .frame(width: .infinity, height: 1)
                            .foregroundColor(Color.grayScale200)
                            .padding(.bottom, 16)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            } else {
                NonContentView(title: contentTab)
            }
        }
    }
    
    
}

// MARK: - Preview
#Preview {
    MyContentMngView()
}
