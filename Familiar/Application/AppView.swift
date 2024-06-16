//
//  AppView.swift
//  Familiar
//
//  Created by 준호 on 6/13/24.
//
import SwiftUI

struct AppView: View {
    @StateObject private var authVM = AuthVM()
    @State private var isLoggedIn: Bool? = nil
    @State private var isRoomJoined: Bool? = nil
    @State private var showSplash = true

    var body: some View {
        NavigationStack {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.showSplash = false
                            self.checkLoginStatus()
                        }
                    }
            } else if let isLoggedIn = isLoggedIn {
                if !isLoggedIn {
                    LoginView()
                } else if let isRoomJoined = isRoomJoined {
                    if isRoomJoined {
                        ContentView()
                    } else {
                        RoomView()
                    }
                }
            } else {
                EmptyView()
            }
        }
        .onChange(of: isRoomJoined) { newValue in
            if newValue == true {
                // 상태 업데이트를 통해 화면 전환을 처리
                isRoomJoined = true
            }
        }
    }

    private func checkLoginStatus() {
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        let refreshToken = userDefaults.string(forKey: "refreshToken")
        
        if let _ = accessToken, let _ = refreshToken {
            isLoggedIn = true
            checkRoomJoinStatus()
        } else {
            isLoggedIn = false
        }
    }
    
    private func checkRoomJoinStatus() {
        let userDefaults = UserDefaults.standard
        let isRoomJoin = userDefaults.bool(forKey: "isRoomJoin")
        
        if isRoomJoin {
            isRoomJoined = true
        } else {
            isRoomJoined = false
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
