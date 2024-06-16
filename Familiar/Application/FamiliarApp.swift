//
//  FamiliarApp.swift
//  Familiar
//
//  Created by 준호 on 5/17/24.
//

import SwiftUI
import KakaoSDKCommon

@main
struct FamiliarApp: App {
    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["NATIVE_APP_KEY"] ?? "" ///값 가져오기
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String) ///kakao SDK init
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
