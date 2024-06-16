//
//  LoginResponseDto.swift
//  Familiar
//
//  Created by 준호 on 6/13/24.
//

import Foundation

struct LoginResponseDto: Codable {
    let accessToken: String?
    let refreshToken: String?
    let message: String?
}
