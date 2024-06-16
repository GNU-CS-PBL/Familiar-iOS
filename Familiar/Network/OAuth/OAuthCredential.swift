//
//  OAuthCredential.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import Foundation
import Alamofire

struct OAuthCredential : AuthenticationCredential {
    
    let accessToken: String
    
    let refreshToken: String
    
    /// 토큰 만료 시간은 따로 백엔드에서 넘겨 주지 않음.
    let expiration: Date
    
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 30) > expiration }
}
