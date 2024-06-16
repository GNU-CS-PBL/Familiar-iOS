//
//  RegProfileView.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

struct RegProfileView: View {
    @Binding var userData: RegRequestDto
    
    @State var isActive = false
    @State var showingSheet = false
    @State private var showCamera = false
    @State private var image: UIImage?
    @State var showImagePicker = false
    
    var body: some View {
        VStack {
            explnTitle
            profileSelect
            Spacer()
            nextButton
        }
        .padding(.horizontal, 24)
    }
}

extension RegProfileView {
    private var explnTitle: some View {
        VStack(spacing: 12) {
            HStack {
                Text("테스터 님의 프로필 이미지를\n등록해주세요.")
                    .font(
                        Font.custom("Pretendard", size: 24)
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
        .padding(.bottom, 160)
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
                    Constants.ProfileButton(image: "profile-default")
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
                CameraView(selection: $image)
                    .background(.black)
            }
            .sheet(isPresented: $showImagePicker) {
                PhotoPicker(selection: $image)
            }
        }
    }
    
    private var nextButton: some View {
        CustomNavLink(destination: RegTermView(userData: $userData)
                       ,isActive: $isActive
        ) {
            Button(action: {
                /// image를 base64로 변환
//                userData.image = image
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
        .padding(.bottom, 42)
    }
}

// MARK: - Preview
struct RegProfileView_Previews: PreviewProvider {
    @State static var testData = RegRequestDto(provider: "123", accessToken: "123", name: "test", image: "cat", birth: "", marketingAgree: false, field2: false)
    
    static var previews: some View {
        RegProfileView(userData: $testData)
    }
}
