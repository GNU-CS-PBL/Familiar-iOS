//
//  TagProfileView.swift
//  practice2
//
//  Created by 박예진 on 3/26/24.
//

import SwiftUI

struct TagProfileView: View {
    
    var tagInfo: TagInfo
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                Image(uiImage: tagInfo.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width:100, height: 100)
                    .clipShape(Circle())
                    .padding(.bottom,10)
                    .opacity(tagInfo.isPressProfile ? 0.5 : 1.0)
                
                // 이미지 클릭시 투명도 조절 & 체크 마크 표시
                
                if tagInfo.isPressProfile {
//                    Image(systemName: "checkmark")
//                        .font(.system(size: 35))
//                        .bold()
//                        .foregroundColor(Constants.Colors.main400)
                
                }
            }
            
            Text(tagInfo.nickName)
            
        } // : VStack
        
    }
}

#Preview {
    TagProfileView(tagInfo: .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 0))
}
