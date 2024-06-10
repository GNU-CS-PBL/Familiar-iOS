//
//  RoomMngView.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI


// MARK: - State
struct RoomMngView {
    @State var buttonTabbed: Bool = false
    @State var mngTab: String = "수락"
    @State var roomCode: String = "A1WIE3VX"
    
    @State var userNum: Int = 3
}

// MARK: - View
extension RoomMngView: View {
    var body: some View {
        VStack(spacing: 0) {
            contentSelectBar
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color.grayScale100)
            if (mngTab == "수락") {
                acceptUsers
            } else if (mngTab == "강퇴 / 위임") {
                mngUsers
            } else {
                mngRoomCode
            }
            Spacer()
        }
    }
}


// MARK: - ViewDetail
extension RoomMngView {
    private var contentSelectBar: some View {
        HStack(alignment: .center) {
            HStack(alignment: .top, spacing: 0) {
                /// 게시물
                Button(action: {
                    mngTab = "수락"
                }){
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("수락")
                                .font(Font.custom("Pretendard-medium", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(mngTab == "수락" ? Color.main200 : Color.grayScale700)
                            
                            Divider()
                                .frame(width: 41, height: 2)
                                .background(mngTab == "수락" ? Color.main200 : Color.white)
                        }
                        .padding(0)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(0)
                .frame(width: 72, height: 44, alignment: .bottom)
                
                ///댓글
                Button(action: {
                    mngTab = "강퇴 / 위임"
                }) {
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("강퇴 / 위임")
                                .font(Font.custom("Pretendard", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(mngTab == "강퇴 / 위임" ? Color.main200 : Color.grayScale700)
                            
                            Divider()
                                .frame(width: 72, height: 2)
                                .background(mngTab == "강퇴 / 위임" ? Color.main200 : Color.white)
                        }
                        .padding(0)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(0)
                .frame(width: 72, height: 44, alignment: .bottom)
                
                ///댓글
                Button(action: {
                    mngTab = "방 코드"
                }) {
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("방 코드")
                                .font(Font.custom("Pretendard", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(mngTab == "방 코드" ? Color.main200 : Color.grayScale700)
                            
                            Divider()
                                .frame(width: 52, height: 2)
                                .background(mngTab == "방 코드" ? Color.main200 : Color.white)
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
    
    private var acceptUsers: some View {
        ScrollView {
            VStack(spacing: 0) {
                if userNum > 0 {
                    ForEach(1...userNum, id: \.self) { count in
                        /// 수락 Element
                        AcceptUserElement(nickname: "테스터")
                    }
                    .padding(.vertical, 16)
                }
            }
        }
        .padding(.top, 8)
        .padding(.horizontal, 16)
    }
    
    private var mngUsers: some View {
        ScrollView {
            VStack(spacing: 0) {
                if userNum > 0 {
                    ForEach(1...userNum, id: \.self) { count in
                        /// 강퇴/위임 Element
                        MngUserElement(nickname: "테스터")
                    }
                    .padding(.vertical, 16)
                }
            }
        }
        .padding(.top, 8)
        .padding(.horizontal, 16)
    }
    
    private var mngRoomCode: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("방 코드는")
                .font(.custom("Pretendard-Medium", size: 18))
            Text(roomCode)
                .font(.custom("Pretendard-Medium", size: 36))
            Spacer()
            Button(action: {
    //            authVM.nickNameValidate(nickname: nickname)
    //            authVM.taskError.sink { errMsg in /// 오류 시
    //                print(errMsg)
    //                isError = true
    //            }
    //            .store(in: &authVM.subscription)
    //            authVM.taskSuccess.sink { /// 성공 시
    //                print("셍공")
    //                isError  = false
    //                /// 성공 시 뒤로가기 로직
    //            }
    //            .store(in: &authVM.subscription)
            }) {
                Text("재발급")
                    .font(.headline).bold()
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .foregroundColor(.white)
                    .background(Color.main300)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 24)
        .background(Color.white)
    }
}

// MARK: - Preview
#Preview {
    RoomMngView()
}
