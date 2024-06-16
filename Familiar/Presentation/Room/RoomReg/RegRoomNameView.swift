//
//  RegRoomNameView.swift
//  Familiar
//
//  Created by 준호 on 6/15/24.
//

import SwiftUI

struct RegRoomNameView: View {
//    @StateObject private var roomVM = RoomVM()
    
    @State var roomData = RegRoomRequestDto(roomName: "", roomImage: "", alias: "")
    @FocusState private var isTextFieldFocused: Bool
    
    @State var roomname = ""
    @State var isActive = false
    @State var showingSheet = false
    @State private var showCamera = false
    @State private var image: UIImage?
    @State var showImagePicker = false
    
    var body: some View {
        VStack() {
            explnTitle
            profileSelect
            roomnameField
            Spacer()
            nextButton
        }
        .padding(.horizontal, 24)
    }
}

extension RegRoomNameView {
    private var explnTitle: some View {
        VStack(spacing: 12) {
            HStack {
                Text("생성하실 방 이름과 이미지를\n등록해주세요.")
                    .font(
                        Font.custom("Pretendard-Bold", size: 24)
                            .weight(.bold)
                    )
                    .foregroundColor(Color.grayScale900)
                Spacer()
            }
            HStack {
                Text("방 구성원들에게 보여줄 수도 있어요!")
                    .font(Font.custom("Pretendard", size: 16))
                    .foregroundColor(Color.grayScale400)
                Spacer()
            }
        }
        .padding(.top, 72)
    }
    private var profileSelect: some View {
        ZStack {
            Button(action: {
                self.showingSheet = true
            }) {
                if let displayImage = image {
                    Image(uiImage: displayImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .clipped()
                        .clipShape(Circle())
                    HStack(alignment: .center, spacing: 0) {
                        Image("pencil")
                            .frame(width: 18, height: 18)
                    }
                    
                    .padding(7)
                    .frame(width: 32, height: 32, alignment: .center)
                    .background(Color.main300)
                    .cornerRadius(36)
                    .overlay(
                        RoundedRectangle(cornerRadius: 36)
                            .inset(by: 1)
                            .stroke(.white, lineWidth: 2)
                    )
                    .offset(x: -30,y: 30)
                } else {
                    Constants.ProfileButton(image: "room")
                }
            }
            .confirmationDialog("타이틀", isPresented: $showingSheet) {
                Button("사진 촬영", role: .none) {
                    showCamera = true
                }
                Button("앨범", role: .none) {
                    showImagePicker.toggle()
                }
                
                Button("취소", role: .cancel) {}
            }.sheet(isPresented: $showCamera) {
//                CameraView(image: $image)
            }
            .sheet(isPresented: $showImagePicker) {
//                  ImagePicker(image: $image)
            }
        }
        .padding(.top, 120)
        .padding(.bottom, 16)
    }
    
    private var roomnameField: some View {
        VStack {
            StdTextField(text: $roomData.roomName, maxLength: 10, placeholder: "방 이름을 입력해주세요.")
                .focused($isTextFieldFocused)
        }
    }
    
    private var nextButton: some View {
        CustomNavLink(destination: RegRoomAliasView(roomData: $roomData)
                       ,isActive: $isActive
        ) {
            Button(action: {
                    isActive = true
            }) {
                Text("다 음")
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



struct RegRoomNameView_Previews: PreviewProvider {
    static var previews: some View {
        RegRoomNameView()
    }
}
