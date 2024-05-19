//
//  AlarmListView.swift
//  practice
//
//  Created by 박예진 on 3/16/24.
//

import SwiftUI

struct AlarmListView: View {
    
    @Binding var isSelected: Bool
    @State var alarmType : String = "알림"
    @State var alarmTime : Int = 3
    
    @State var alarmText : String =
    "안녕하세요"
    
    //    @State var alarmUserName : String = "모리"
    //    @State var alarmText : String = "'안녕하세요!"
    
    
    
    
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                Image("bell")
                    .padding(.leading, 24)
                
                Text(alarmType)
                    .font(.title3)
                    .padding(.leading, 11)
                
                Spacer()
                
                Text("\(alarmTime)시간 전")
                    .foregroundColor(Constants.Colors.grayScale500)
                    .padding(.trailing, 24)
                    .padding(.top, 16)
                
                
            } // : HStack
            
            Text(alarmText)
                .font(.body)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 68)
                .padding(.trailing, 24)
                .padding(.bottom, 16)
        }
        .padding(.vertical, 15)
        .background(isSelected ? .white : Constants.Colors.main100)
        
        
        
        
        
        
        //
        //                // Todo 일 때
        //
        //                if alarmType == "Todo"  {
        //                    Text("\(alarmUserName)님이 \(alarmText)...' Todo에 회원님을 태그하셨습니다.")
        //                        .font(.body)
        //                        .lineLimit(2)
        //                        .padding(.bottom)
        //
        //                    // text 정렬
        //                        .frame(maxWidth: .infinity, alignment: .leading)
        //                        .padding(.leading,55)
        //
        //
        //
        //
        //
        //                }
        //
        //                // 캘린더 일 때 (추가하기)
        //                //            if alarmType == "캘린더" {
        //                //
        //                //            }
        //
        //                // 댓글, 반응 일 때
        //
        //                else {
        //
        //                    Text("\(alarmUserName)님이 \(alarmText)...' 글에 \(alarmType)을 다셨습니다.")
        //                        .font(.body)
        //                        .lineLimit(2)
        //
        //
        //
        //
        //
        //                }
        
        
        
        //            } // : VStack
        
        
        
        
        //            Divider()
        
        
    }
    
}

#Preview {
    AlarmListView(isSelected: .constant(false))
    
}
