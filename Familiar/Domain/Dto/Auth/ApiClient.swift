//
//  ApiClient.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import Foundation
import Alamofire

// MARK: - api 호출 클라이언트
/// ApiClient.shared.session() <= 사용방식
final class ApiClient {
    
    /// 싱글톤
    static let shared = ApiClient()
    
    /// 베이스 URL
    static let BASE_URL = "http://43.201.177.231:8080/"
    
    /// 인터셉터 선언
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor() // application/json
    ])
    
    /// Logger 선언
    let monitors = [ApiLogger()] as [EventMonitor]
    
    /// 세션 선언
    var session: Session
    
    init() {
        print("ApiClient - init() called")
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
