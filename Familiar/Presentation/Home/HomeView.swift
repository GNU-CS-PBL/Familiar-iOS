//
//  HomeView.swift
//  Familiar
//
//  Created by 준호 on 5/17/24.
//

import SwiftUI

struct HomeView: View {
    @State var nickname = "테스터"
    @State var roomname = "테테"
    @State var pressBellButton : Bool = false
    @State var pressPlusButton : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .bottomTrailing) {
                ScrollView {
                    VStack {
                        alarm
                        title
                        advertisement
                        Divider()
                            .background(Constants.Colors.grayScale300)
                        post
                        Spacer()
                    }
                }
                plusBotton
            }
        }
    }
}

extension HomeView {
    private var alarm: some View {
        
      
            HStack{
                Spacer()
                NavigationLink {
                    AlarmView()
                } label: {
                    Image("bell")
                        .resizable()
                        .frame(width:35, height: 35)
                
                }
              
            }
        .padding(.trailing)
    }
    
    private var title: some View {
        VStack {
            HStack {
                Text(nickname)
                    .font(
                        Font.custom("pretendard", size: 24)
                    )
                    .foregroundColor(Constants.Colors.main200)
                    .padding(.trailing, 2)
                Text("님의,")
                    .font(
                        Font.custom("pretendard", size: 24)
                    )
                Spacer()
            }
            HStack {
                Text(roomname)
                    .font(
                        Font.custom("pretendard", size: 24)
                    )
                    .foregroundColor(Constants.Colors.main300)
                    .padding(.trailing, 2)
                Text("하우스")
                    .font(
                        Font.custom("pretendard", size: 24)
                    )
                Spacer()
            }
        }
        .padding(.leading)
    }
    
    private var advertisement: some View {
        Text("광고")
            .frame(width: 300, height: 140)
            .background(Constants.Colors.grayScale200)
            .cornerRadius(16)
            .padding(.top, 25)
            .padding(.bottom, 15)
    }
    
    private var post : some View {
        LazyVStack {
            ForEach(1...10, id: \.self) { count in
                PostListView()
            }
        }
    }
    
    
    private var plusBotton: some View {
    
        Button {
            pressPlusButton.toggle()
            
        } label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
            
        }
        
        .background(Color(.white))
        .foregroundColor(Constants.Colors.main400)
        .clipShape(Circle())
        .padding()
        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 5)
        .fullScreenCover(isPresented: $pressPlusButton) {
            WritePostView(userProfileImage: .constant(UIImage(named: "cat")!))
        }
    }
} // : extension




struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
