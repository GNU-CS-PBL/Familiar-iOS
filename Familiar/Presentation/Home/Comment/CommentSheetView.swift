//
//  ComentSheet.swift
//  practice
//
//  Created by 박예진 on 3/15/24.
//

import SwiftUI

struct ComentSheetView: View {
    
    @Binding var userProfileImage : UIImage
    @State var userName: String = "고먐미"
    @State var comment: String = ""
    @State var comentWriteZone : String = ""
    @State var commentList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack(alignment: .top){
                VStack(spacing: 7) {
                    RoundedRectangle(cornerRadius: 3)
                        .foregroundColor(Constants.Colors.grayScale800.opacity(0.3))
                        .frame(width: 36, height: 5)
                        .padding(.top, 4)
                        .padding(.bottom, 5)
                    Text("댓글")
                        .font(.custom("pretendard", size: 18))
                        .bold()
                }
                
                HStack {
                    Spacer()
                    Button {
                        // Sheet 닫기 Action
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Constants.Colors.grayScale800.opacity(0.6))
                            .font(.body.bold())
                            .frame(width: 30, height: 30)
                            .background(Constants.Colors.grayScale500.opacity(0.1))
                            .clipShape(.circle)
                    }
                    .padding(.top, 17)
                }
                
            } // : ZStack
            
            .padding(.horizontal, 11)
            .padding(.bottom, 20)
            
            List {
                ForEach(commentList, id: \.self) { _ in
                    ComentListView(
                        userProfileImage: self.$userProfileImage,
                        userNickName: .constant("해피")
                    )
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .environment(\.locale, Locale(identifier: "ko_kr"))
            
            commentInputView
        }
    }
    
    private var commentInputView: some View {
        HStack(spacing: 12) {
            Image(uiImage: self.userProfileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .cornerRadius(24)
            HStack {
                TextField("\(userName)님 글에 댓글 달기...",
                          text: $comment)
//                .font(.system(size: 14))
                .font(Font.custom("pretendard", size: 14))
                Button {
                   createComment()
                } label: {
                    Image(systemName: "chevron.up")
                        .font(.system(size: 14).bold())
                        .foregroundColor(Constants.Colors.grayScale50)
                        .frame(width: 24, height: 24)
                        .background(comment.isEmpty ? Constants.Colors.grayScale800 : Constants.Colors.main200)
                        .clipShape(Circle())
                }
                
            }
            .frame(height: 48)
            .padding(.horizontal, 12)
            .cornerRadius(32)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Constants.Colors.grayScale200, lineWidth: 1)
            )
        } // : HStack
        .padding(.horizontal, 24)
        .padding(.vertical)
    }
                
    // MARK: - Create Comment
    func createComment() {
        
    }

    func delete(indexSet: IndexSet) {
        commentList.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ComentSheetView(userProfileImage: .constant(UIImage(named: "cat")!))
    }
}
