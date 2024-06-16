//
//  RegRequestDto.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import Foundation

struct RegRequestDto: Codable {
    var provider: String        /// OAuth 제공자
    var accessToken: String     /// OAuth accessToken or Code
    var name: String
    var image: String
    var birth: String
    var marketingAgree: Bool
    var field2: Bool           /// 방 가입 여부. 무조건 false (나중에 삭제 예정)
}
