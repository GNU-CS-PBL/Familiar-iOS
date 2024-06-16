//
//  LoginView.swift
//  Familiars
//
//  Created by 준호 on 3/15/24.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import AuthenticationServices

// MARK: - State
struct LoginView {
    @StateObject private var authVM = AuthVM()
    @State var isActive = false
    @State var isRoomViewActive = false
    
    @State var provider: String = ""
    @State var toToken: String = ""
    
    let topPadding: CGFloat = 100
}

// MARK: - Frame
extension LoginView: View {
    var body: some View {
        VStack {
            appTitle
            appLogo
            Spacer()
            socialLoginButton
        }
        .padding(.top, topPadding)
        .padding(.bottom, 64)
        .onAppear {
            authVM.loginResponse.sink { response in
                if response.accessToken != nil {
                    let userDefaults = UserDefaults.standard
                    let isRoomJoin = userDefaults.bool(forKey: "isRoomJoin")
                    
                    if isRoomJoin {
                        isActive = true
                    } else {
                        isRoomViewActive = true
                    }
                } else {
                    // 처리 로직 추가
                }
            }.store(in: &authVM.subscription)
            
            authVM.taskError.sink { errorMsg in
                if errorMsg.contains("회원가입이 필요합니다.") {
                    isActive = true
                }
            }.store(in: &authVM.subscription)
        }
        .background(
            NavigationLink(destination: ContentView(), isActive: $isActive) {
                EmptyView()
            }
            .hidden()
        )
        .background(
            NavigationLink(destination: RoomView(), isActive: $isRoomViewActive) {
                EmptyView()
            }
            .hidden()
        )
    }
}

// MARK: - View Detail
extension LoginView {
    private var appTitle: some View {
        VStack {
            Text("패밀리어")
                .font(Font.custom("WAGURI-TTF", size: 64))
                .multilineTextAlignment(.center)
                .foregroundColor(Constants.Colors.main200)
            Text("가족과 함께니까")
                .font(Font.custom("Pretendard-Medium", size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(Constants.Colors.grayScale600)
        }
        .padding(.top, 100)
    }
    
    private var appLogo: some View {
        EmptyView()
    }
    
    private var socialLoginButton: some View {
        VStack(alignment: .center, spacing: 12) {
            /// 카카오
            CustomNavLink(destination: RegNicknameView(provider: provider, token: toToken)
                           , isActive: $isActive) {
                Button {
                    if UserApi.isKakaoTalkLoginAvailable() {
                        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                            if let token = oauthToken?.accessToken {
                                authVM.kakaoLogin(token: token)
                                toToken = token
                                provider = "kakao"
                            } else {
                                // 처리 로직 추가
                            }
                        }
                    } else {
                        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                            if let token = oauthToken?.accessToken {
                                authVM.kakaoLogin(token: token)
                                toToken = token
                                provider = "kakao"
                            } else {
                                // 처리 로직 추가
                            }
                        }
                    }
                } label: {
                    Image("login-kakao")
                        .resizable()
                        .frame(width: 343, height: 48)
                }
            }
            /// 네이버
            /// 애플
            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        print("Apple Login Successful")
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                            print(IdentityToken ?? "")
                            // authVM.appleLogin(token: IdentityToken!)
                            // toToken = IdentityToken ?? ""
                            // log = "apple"
                            /// API 연결 위치
                        default:
                            break
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        print("error")
                    }
                }
            )
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 50)
            .cornerRadius(5)
        }
    }
}






//import SwiftUI
//import KakaoSDKAuth
//import KakaoSDKUser
//import KakaoSDKCommon
//import AuthenticationServices
//
//// MARK: - State
//struct LoginView {
//    @StateObject private var authVM = AuthVM()
//    @State var isActive = false
//    
//    @State var provider: String = ""
//    @State var toToken: String = ""
//    
//    let topPadding: CGFloat = 100
//}
//
//// MARK: - Frame
//extension LoginView: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                appTitle
//                appLogo
//                Spacer()
//                socialLoginButton
//            }
//            .padding(.top, topPadding)
//            .padding(.bottom, 64)
//        }
//        .onAppear {
//            authVM.taskSuccess .sink {
////                isActive = true
//            }.store(in: &authVM.subscription)
//            
//            authVM.taskError .sink { errorMsg in
//                if(errorMsg.contains("401")) { isActive = true }
//            }.store(in: &authVM.subscription)
//        }
//    }
//}
//
//// MARK: - View Detail
//extension LoginView {
//    private var appTitle: some View {
//        VStack {
//            Text("패밀리어")
//                .font(Font.custom("WAGURI-TTF", size: 64))
//                .multilineTextAlignment(.center)
//                .foregroundColor(Constants.Colors.main200)
//            Text("가족과 함께니까")
//                .font(Font.custom("Pretendard-Medium", size: 16))
//                .multilineTextAlignment(.center)
//                .foregroundColor(Constants.Colors.grayScale600)
//        }
//        .padding(.top, 100)
//    }
//    
//    private var appLogo: some View {
//        EmptyView()
//    }
//    
//    private var socialLoginButton: some View {
//        VStack(alignment: .center, spacing: 12) {
//            /// 카카오
//            CustomNavLink(destination: RegNicknameView(provider: provider, token: toToken)
//                           , isActive: $isActive) {
//                Button {
//                    if (UserApi.isKakaoTalkLoginAvailable()) {
//                        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                            if let token = oauthToken?.accessToken {
//                                authVM.kakaoLogin(token: token)
//                                toToken = token
//                                print("\n\n\n까까오")
//                                print(toToken)
//                                provider = "kakao"
//                                isActive = true
//                            } else {
////                                isActive = true
//                            }
//                        }
//                    } else {
//                        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//                            if let token = oauthToken?.accessToken {
//                                authVM.kakaoLogin(token: token)
//                                toToken = token
//                                print("\n\n\n까까오")
//                                print(toToken)
//                                provider = "kakao"
//                                isActive = true
//                            }
//                            else {
//                                //                                isError = true
////                                isActive = true
//                            }
//                        }
//                    }
//                } label : {
//                    Image("login-kakao")
//                        .resizable()
//                        .frame(width: 343,height: 48)
//                }
//            }
//            /// 네이버
//            /// 애플
//            SignInWithAppleButton(
//                onRequest: { request in
//                    request.requestedScopes = [.fullName, .email]
//                },
//                onCompletion: { result in
//                    switch result {
//                    case .success(let authResults):
//                        print("Apple Login Successful")
//                        switch authResults.credential{
//                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//                            let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
//                            print(IdentityToken ?? "")
////                            authVM.appleLogin(token: IdentityToken!)
////                            toToken = IdentityToken ?? ""
////                            log = "apple"
//                            /// API 연결 위치
//                        default:
//                            break
//                        }
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                        print("error")
//                    }
//                }
//            )
//            .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
//            .cornerRadius(5)
//        }
//    }
//}
