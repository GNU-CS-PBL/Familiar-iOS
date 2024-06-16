//
//  AuthRouter.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import Foundation
import Alamofire

enum AuthRouter: URLRequestConvertible {
    
    // MARK: - case 분류
    case regUser(regRequestDto: RegRequestDto)
    ///  카카오 로그인
    case kakaoLogin(token: String)
    ///  닉네임 중복 확인
    case nickNameValidate(nickname: String)
    /// 로그아웃
    case logout
    ///. 회원 탈퇴
    case deleteUser
    /// 토큰 재발급
    case tokenRefresh(refreshToken: String)
    
    // MARK: - BaseURL
    var baseURL: URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    
    // MARK: - EndPoint
    var endPoint: String {
        switch self {
        case .regUser:
            return "api/register"
        case .kakaoLogin:
            return "api/callback"
        case .nickNameValidate:
            return "api/auth/checkName"
        case .logout:
            return "api/logout"
        case .deleteUser:
            return "api/unregister"
        case .tokenRefresh:
            return "reissue"
        default:
            return ""
        }
    }
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .regUser:
            return .post
        case .kakaoLogin:
            return .post
        case .nickNameValidate:
            return .get
        case .logout:
            return .delete
        case .deleteUser:
            return .delete
        case .tokenRefresh:
            return .post
        default:
            return .head
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters{
        var params = Parameters()
        switch self {
        case .regUser(let regRequestDto):
            params["provider"] = regRequestDto.provider
            params["accessToken"] = regRequestDto.accessToken
            params["name"] = regRequestDto.name
            params["image"] = regRequestDto.image
            params["birth"] = regRequestDto.birth
            params["marketingAgree"] = regRequestDto.marketingAgree
            params["field2"] = regRequestDto.field2
            return params
        case .kakaoLogin(let token):
            params["accessToken"] = token
            return params
        case .nickNameValidate(let nickname):
            params["data"] = nickname
            return params
        case .tokenRefresh(let refreshToken):
            let tokenData = UserDefaultsManager.shared.getTokens()
            params["refreshToken"] = tokenData.refresh
            return params
        default:
            return params
        }
    }
    
    // MARK: - asURLRequest()
    func asURLRequest() throws -> URLRequest {
        /// BaseURL에 EndPoint 추가
        let url = baseURL.appendingPathComponent(endPoint)
        /// 반환해줄 request
        var request = URLRequest(url: url)
        /// method 지정
        request.method = method
        
        switch self {
        case .nickNameValidate:/// query string
            request = try URLEncoding.queryString.encode(request, with: parameters)
            return request
        default:/// raw
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
            return request
        }
    }
}
