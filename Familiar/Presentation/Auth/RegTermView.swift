//
//  RegTermView.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

struct RegTermView: View {
    @StateObject private var authVM = AuthVM()
    @Binding var userData: RegRequestDto
    
    @State private var ischeckPrivacy = false  /// 개인정보처리방침[필수]
    @State private var ischeckUsage = false    /// 이용약관[필수]
    @State private var ischeckMarketing = false/// 마케팅 [선택]
    @State private var ischeckAll = false
    
    @State private var canNavigate = false
    
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("이용약관에 \n동의 해주세요").font(.title).bold()
                    .frame(width: 343, alignment: .topLeading)
                Spacer().frame(height: 100)
                
                HStack {
                    Toggle(isOn: $ischeckPrivacy) {
                        HStack(spacing: 4) {
                            Text("*").foregroundColor(.red)
                            Text("[필수] 개인정보 처리방침")
                                .font(Font.custom("Pretendard", size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                        }
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.main200))
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("보기")
                            .font(
                                Font.custom("Pretendard", size: 14)
                                .weight(.bold)
                            )
                            .foregroundColor(Color.grayScale400)
                    }
                }
                
                HStack {
                    Toggle(isOn: $ischeckUsage) {
                        HStack(spacing: 4) {
                            Text("*").foregroundColor(.red)
                            Text("[필수] 서비스 이용약관")
                                .font(Font.custom("Pretendard", size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                        }
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.main200))
                    
                    Spacer()
                    Button(action: {}) {
                        Text("보기")
                            .font(
                                Font.custom("Pretendard", size: 14)
                                .weight(.bold)
                            )
                            .foregroundColor(Color.grayScale400)
                    }
                }
                
                HStack {
                    Toggle(isOn: $ischeckMarketing) {
                        HStack(spacing: 4) {
                            Text("").foregroundColor(.red)
                            Text("[선택] 마케팅 수신 동의")
                                .font(Font.custom("Pretendard", size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.26))
                        }
                        //여기에 보기 버튼 둬야함
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.main200))
                    
                    Spacer()
                    Button(action: {}) {
                        Text("보기")
                            .font(
                                Font.custom("Pretendard", size: 14)
                                .weight(.bold)
                            )
                            .foregroundColor(Color.grayScale400)
                    }
                }
                Divider()
                
                Toggle(isOn: $ischeckAll) {
                    Text("전체 약관동의")
                        .font(
                    Font.custom("Pretendard", size: 14)
                    .weight(.bold)
                    )
                    .kerning(0.1)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.grayScale800)
                }
                .toggleStyle(SwitchToggleStyle(tint: Color.main200))
                .onChange(of: ischeckAll) { value in
                    if value {
                        ischeckPrivacy = true
                        ischeckUsage = true
                        ischeckMarketing = true
                        
                    } else {
                        ischeckPrivacy = false
                        ischeckUsage = false
                        ischeckMarketing = false
                        
                    }
                }
               
                Text("서비스 이용을 위해 위 약관들을 모두 동의합니다.").font(Font.custom("Pretendard", size: 11))
                    .kerning(0.25)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.grayScale500)
                    .padding(.top, -5)
                Spacer().frame(height: 50)
            }.padding(.all)
            
            Button(action: {
                if ischeckMarketing {
                    userData.marketingAgree = true
                }
//                authVM.regUser(regRequestDto: userData)
//                print(userData)
//                
//                authVM.taskError.sink { errMsg in /// 오류 시
//                    print(errMsg)
//                }
//                .store(in: &authVM.subscription)
//                
//                authVM.taskSuccess.sink { /// 성공 시
                    isActive = true
//                    print("회원가입 성공")
//                }
//                .store(in: &authVM.subscription)
            }) {
                Text("완료")
                    .font(.headline).bold()
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .foregroundColor((ischeckPrivacy && ischeckUsage) ? Color.white : Color.grayScale600)
                    .background((ischeckPrivacy && ischeckUsage) ? Color.main300 : Color.grayScale200)
                    .cornerRadius(10)
            }
            .padding(.all)
            .disabled(!(ischeckPrivacy && ischeckUsage))
            .background(
                NavigationLink(destination: RegEndingView(nickname: userData.name), isActive: $isActive) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}

// MARK: - Preview
struct RegTermView_Previews: PreviewProvider {
    @State static var testData = RegRequestDto(provider: "123", accessToken: "123", name: "test", image: "cat", birth: "", marketingAgree: false, field2: false)
    
    static var previews: some View {
        NavigationStack {
            RegTermView(userData: $testData)
        }
    }
}
