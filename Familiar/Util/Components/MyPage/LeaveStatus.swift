//
//  LeaveStatus.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import Foundation

enum LeaveStatus: Identifiable {
    var id: Int { self.hashValue }
    case success, failure
}
