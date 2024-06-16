//
//  RegRoomAliasView.swift
//  Familiar
//
//  Created by 준호 on 6/15/24.
//

import SwiftUI

struct RegRoomAliasView: View {
//    @StateObject private var roomVM = RoomVM()
    
    @Binding var roomData: RegRoomRequestDto
    @FocusState private var isTextFieldFocused: Bool
    
    @State var isActive = false
    @State var showingSheet = false
    @State private var showCamera = false
    @State private var image: UIImage?
    @State var showImagePicker = false
    
    var body: some View {
        VStack() {
            explnTitle
            aliasField
                .padding(.top, 156)
            Spacer()
            nextButton
        }
        .padding(.horizontal, 24)
    }
}

extension RegRoomAliasView {
    private var explnTitle: some View {
        VStack(spacing: 12) {
            HStack {
                Text("방에서는\n어떻게 불러드리면 될까요?")
                    .font(
                        Font.custom("Pretendard-Bold", size: 24)
                            .weight(.bold)
                    )
                    .foregroundColor(Color.grayScale900)
                Spacer()
            }
            HStack {
                Text("방 구성원들에게 해당 별칭으로 보여요!")
                    .font(Font.custom("Pretendard", size: 16))
                    .foregroundColor(Color.grayScale400)
                Spacer()
            }
        }
        .padding(.top, 72)
    }
    
    private var aliasField: some View {
        VStack {
            StdTextField(text: $roomData.alias, maxLength: 10, placeholder: "별칭을 입력해주세요.")
                .focused($isTextFieldFocused)
        }
    }
    
    private var nextButton: some View {
        CustomNavLink(destination: RegRoomEndingView(roomName: roomData.roomName)
                       ,isActive: $isActive
        ) {
            Button(action: {
//                roomVM.createRoom(createRoomData: roomData)
//                roomVM.taskError.sink { errMsg in /// 오류 시
//                    print(errMsg)
//                }
//                .store(in: &roomVM.subscription)
//                roomVM.taskSuccess.sink { /// 성공 시
//                    print(roomData.nickname)
//                    print("셍공")
                    isActive = true
//                }
//                .store(in: &roomVM.subscription)
            }) {
                Text("완 료")
                    .font(.headline).bold()
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .foregroundColor(.white)
                    .background(Color.main300)
                    .cornerRadius(10)
            }
        }
        .padding(.bottom, 42) // 수정 필요
    }
}



//struct RegRoomAliasView_Previews: PreviewProvider {
//    static var roomData = RegRoomRequestDto(roomName: "", roomImage: "", alias: "")
//    static var previews: some View {
//        RegRoomAliasView(roomData: $roomData)
//    }
//}
