//
//  AuthApiService.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import Foundation
import Alamofire
import Combine

enum AuthApiService {
    static func regUser(regRequestDto: RegRequestDto) -> AnyPublisher<Bool, Error> {
        print("AuthApiService - saveUserInfo() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.regUser(regRequestDto: regRequestDto))
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 전송에 실패했습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                default:
                    throw NSError(domain: "서버의 오류로 전송에 실패했습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func kakaoLogin(token: String) -> AnyPublisher<LoginResponseDto, Error> {
        print("AuthApiService - kakaoLogin() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.kakaoLogin(token: token))
            .validate(statusCode: 200..<300)
            .publishDecodable(type: LoginResponseDto.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    static func nickNameValidate(nickname: String) -> AnyPublisher<Bool, Error> {
        print("AuthApiService - nickNameValidate() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.nickNameValidate(nickname: nickname))
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let data = response.data else {
                    throw NSError(domain: "서버의 오류로 닉네임 검증을 실패하였습니다.", code: 0, userInfo: nil)
                }
                let isValid = try JSONDecoder().decode(Bool.self, from: data)
                return isValid
            }
            .eraseToAnyPublisher()
    }
}
