//
//  AuthVM.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI
import Combine

class AuthVM: ObservableObject {
    //MARK: properties
    var subscription = Set<AnyCancellable>()
    
    var taskSuccess = PassthroughSubject<Void, Never>()
    var taskError = PassthroughSubject<String, Never>()
    
    var loginResponse = PassthroughSubject<LoginResponseDto, Never>()
    
    func regUser(regRequestDto: RegRequestDto) {
        print("AuthVM: regUser() called")
        AuthApiService.regUser(regRequestDto: regRequestDto)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                if isSuccess {
                    self.taskSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    func kakaoLogin(token: String) {
        print("AuthVM: kakaoLogin() called")
        AuthApiService.kakaoLogin(token: token)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self.taskError.send(error.localizedDescription)
                }
            } receiveValue: { response in
                if let accessToken = response.accessToken, let refreshToken = response.refreshToken {
                    UserDefaultsManager.shared.setTokens(accessToken: accessToken, refreshToken: refreshToken)
                    self.loginResponse.send(response)
                    self.taskSuccess.send()
                } else {
                    self.taskError.send("회원가입이 필요합니다.")
                }
            }
            .store(in: &subscription)
    }
    
    func nickNameValidate(nickname: String) {
        print("AuthVM: nickNameValidate() called")
        AuthApiService.nickNameValidate(nickname: nickname)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(NicknameError.duplicate.localizedDescription)
                }
            } receiveValue: { (isValid: Bool) in
                if isValid {
                    self.taskSuccess.send(())
                } else {
                    self.taskError.send(NicknameError.duplicate.localizedDescription)
                }
            }
            .store(in: &subscription)
    }
}
