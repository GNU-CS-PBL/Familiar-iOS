//
//  NonContentView.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

struct StoreNonReviewView {
    var title: String
}

extension StoreNonReviewView: View {
    var body: some View {
        VStack(alignment: .center,spacing: 8) {
            
            Text("작성된 \(title)이 없어요.")
              .font(Font.custom("Pretendard-medium", size: 18))
              .multilineTextAlignment(.center)
              .foregroundColor(.grayScale900)
              .frame(maxWidth: .infinity, alignment: .top)
            
            Text("아직 작성한 \(title)가 없어요 ㅠ\n구성원들과 함께 나누고 싶은 말들을 적어보아요!")
              .font(Font.custom("Pretendard", size: 14))
              .multilineTextAlignment(.center)
              .foregroundColor(.grayScale500)
              .frame(maxWidth: .infinity, alignment: .top)
        }
        .padding(.vertical, 80)
        
        .background(Color.grayScale50)
    }
}

#Preview {
    StoreNonReviewView(title: "게시물")
}
