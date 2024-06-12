//
//  MyInfoMngView.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

struct MyInfoMngView {
    @State var showingSheet = false
    @State private var showCamera = false
    @State private var image: UIImage?
    @State var showImagePicker = false
    @State var isMarketAgree = false
}

extension MyInfoMngView: View {
    var body: some View {
        VStack(spacing: 0) {
            profileSelect
                .padding(.top, 40)
                .padding(.bottom, 42)
            Divider()
                .frame(minHeight: 8)
                .overlay(Color.grayScale50)
            MyPageElementView(menuTitle: "별칭 설정", emphs: false) {
                EditAliasView()
            }.overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
            MyPageElementView(menuTitle: "닉네임 설정", emphs: false) {
                EditNicknameView()
            }.overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
            MyPageElementView(menuTitle: "생일 설정", emphs: false) {
                EditBirthView()
            }.overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
            marketAgree
            Spacer()
            buttons
        }
    }
}

extension MyInfoMngView {
    private var profileSelect: some View {
        ZStack {
            Button(action: {
                self.showingSheet = true
            }) {
                ZStack(alignment: .bottomTrailing) {
                    if let displayImage = image {
                        Image(uiImage: displayImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipped()
                            .clipShape(Circle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 45)
                                    .stroke(.main100, lineWidth: 1)
                            )
                        HStack(alignment: .center, spacing: 0) {
                            Image(systemName: "pencil")
                                .fontWeight(.bold)
                                .frame(width: 18, height: 18)
                                .foregroundColor(.white)
                        }
                        .padding(7)
                        .frame(width: 32, height: 32, alignment: .center)
                        .background(Color.main300)
                        .clipped()
                        .clipShape(Circle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 36)
                                .inset(by: 1)
                                .stroke(.white, lineWidth: 2)
                        )
                    } else {
                        Constants.ProfileButton(image: "profile-default")
                    }
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
    
    private var marketAgree: some View {
        HStack(alignment: .center, spacing: 8) {
            Text("마케팅 수신동의")
                .font(
                    Font.custom("Pretendard-Regular", size: 16)
                )
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            Toggle("", isOn: $isMarketAgree)
                .toggleStyle(SwitchToggleStyle(tint: Color.main200))
        }
        .padding(16)
        .frame(width: .infinity, height: 56, alignment: .leading)
        .background(Color.white)
    }
    
    private var buttons: some View {
        HStack {
            HStack(spacing: 10) {
                Button(action: {
                    /// api 통신
                }) {
                    Text("로그아웃")
                        .font(Font.custom("Pretendard-Regular", size: 13))
                        .foregroundColor(Color.grayScale300)
                }
                
                Text("|")
                    .foregroundColor(.grayScale50)
                
                Button(action: {
                    /// api 통신
                }) {
                    Text("회원탈퇴")
                        .font(Font.custom("Pretendard-Regular", size: 13))
                        .foregroundColor(Color.grayScale300)
                }
            }
            .padding(.leading, 24)
            Spacer()
        }
        .padding(.bottom, 36)
    }
}

struct MyInfoMngView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoMngView()
    }
}
