//
//  NicknameError.swift
//  Familiar
//
//  Created by 준호 on 4/2/24.
//

import Foundation

enum NicknameError {
    case empty              /// 공백만 들어있거나, 아무것도 들어 있지 않을 경우
    case duplicate          /// 이미 사용중인 닉네임인 경우( 네트워킹 필요)
    case invalidCharacters   /// 정규 표현식에 부합하지 않는 경우
    
    // 에러 설명
    var localizedDescription: String {
        switch self {
        case .empty:
            return "닉네임을 입력해주세요."
        case .duplicate:
            return "이미 사용 중인 닉네임입니다."
        case .invalidCharacters:
            return "닉네임에는 한글, 영어, 숫자만 사용가능합니다."
        }
    }
}
