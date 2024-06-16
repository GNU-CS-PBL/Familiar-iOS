//
//  RoomCodeView.swift
//  Familiar
//
//  Created by 준호 on 6/10/24.
//

import SwiftUI

// MARK: - State
struct RoomCodeView {
//    @Binding var roomId;
    @State var code = "1ABC@12A"
}

// MARK: - View
extension RoomCodeView: View {
    var body: some View {
        VStack(alignment: .center) {
            content
                .padding(.bottom, 70)
        }
        .background(Color.white)
    }
}

// MARK: - View Detail
/// 나중에 방 코드 클릭시 클립박스에 복사되는 기능 추가하기!
extension RoomCodeView {
    private var content: some View {
        VStack(spacing: 16) {
            Text("방 코드는")
                .font(.custom("Pretendard-Medium", size: 18))
            Text(code)
                .font(.custom("Pretendard-Medium", size: 36))
        }
    }
}

struct RoomCodeView_Previews: PreviewProvider {
    static var previews: some View {
        RoomCodeView()
    }
}
