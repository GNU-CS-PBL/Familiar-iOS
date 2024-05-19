//
//  ContentView.swift
//  Familiar
//
//  Created by 준호 on 5/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                CalendarView()
                    .tabItem {
                        Image(selection == 0 ? "tab-on-calendar" : "tab-calendar")
                        Text("일정")
                            .font(Font.custom("Pretendard-medium", size: 12))
                            .multilineTextAlignment(.center)
                    }
                    .tag(0)
                HomeView()
                    .tabItem {
                        Image(selection == 1 ? "tab-on-room" : "tab-room")
                        Text("홈")
                            .font(Font.custom("Pretendard-medium", size: 12))
                            .multilineTextAlignment(.center)
                    }
                    .tag(1)
                
                MyPageView()
                    .tabItem {
                        Image(selection == 2 ? "tab-on-mypage" : "tab-mypage")
                        Text("마이페이지")
                            .font(Font.custom("Pretendard-medium", size: 12))
                            .multilineTextAlignment(.center)
                    }
                    .tag(2)
            }
            .accentColor(Constants.Colors.main300)
        }
    }
}

#Preview {
    ContentView()
}
