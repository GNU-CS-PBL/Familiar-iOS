//
//  ComentSheet.swift
//  practice
//
//  Created by 박예진 on 3/15/24.
//

import SwiftUI

struct ComentSheetView: View {
    
    @State var comentWriteZone : String = ""
    @State var commentList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Color.white
                        .frame(width: 18, height: 18)
                        .padding(12)
                    Spacer()
                    Text("댓글")
                        .font(.system(size: 24, weight: .medium))
                    Spacer()
                    Button {
                        // Sheet 닫기 Action
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .foregroundColor(Constants.Colors.grayScale700)
                            .frame(width: 18, height: 18)
                            .padding(12)
                            .background(Constants.Colors.grayScale200)
                            .clipShape(.circle)
                    }
                }
                .padding(20)
                
                List {
                    ForEach(commentList, id: \.self) { _ in
                        ComentListView(
                            userProfileImage: .constant(UIImage(named: "cat")!),
                            userNickName: .constant("해피")
                        )
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
                .environment(\.locale, Locale(identifier: "ko_kr"))
                
                HStack (spacing: 20) {
                    
                    Constants.CustomTextFieldWithBottomLine($comentWriteZone, placeholder: "댓글을  작성해주세요.")
                    
                    // 작성버튼
                    
                    //            Button {
                    //
                    //            } label: {
                    //                Text("작성")
                    //                    .font(.headline).bold()
                    //                    .foregroundColor(.white)
                    //                    .frame(width: 60, height: 50)
                    //                    .background(Constants.main300)
                    //                    .cornerRadius(10)
                    //                    .padding(.trailing,50)
                    //            }
                    
                } // : HStack
                .padding(.horizontal)
            }
        }
    }
    
    func delete(indexSet: IndexSet) {
        commentList.remove(atOffsets: indexSet)
    }
    
}

#Preview {
    ComentSheetView()
}
