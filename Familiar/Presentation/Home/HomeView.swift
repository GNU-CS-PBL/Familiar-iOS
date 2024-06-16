//
//  HomeView.swift
//  Familiar
//
//  Created by 준호 on 5/17/24.
//

import SwiftUI

struct HomeView: View {
    @State var nickname = "막내"
    @State var roomname = "우리가좍"
    @State var pressBellButton : Bool = false
    @State var pressPlusButton : Bool = false
    
    @State var contentTab: String = "게시물"
    
    
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
            
            .onTapGesture {
                NotificationCenter.default.post(
                    name: .viewTapNotification,
                     object: nil,
                     userInfo: nil
                   )
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
            .padding(.trailing, 16)
            .padding(.vertical, 11)
            .padding(.bottom, 4)
    }
    
    private var title: some View {
        VStack {
            HStack {
                Text(nickname)
                    .font(
                        Font.custom("pretendard-Medium", size: 24)
                    )
                    .foregroundColor(Constants.Colors.main200)
                    .padding(.trailing, 2)
                Text("님의,")
                    .font(
                        Font.custom("pretendard-Medium", size: 24)
                    )
                Spacer()
            }
            HStack {
                Text(roomname)
                    .font(
                        Font.custom("pretendard-Medium", size: 24)
                    )
                    .foregroundColor(Constants.Colors.main300)
                    .padding(.trailing, 2)
                Text("하우스")
                    .font(
                        Font.custom("pretendard-Medium", size: 24)
                    )
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
    
    private var advertisement: some View {
        HStack {
            AdView()
        }
            .frame(height: 118)
            .background(Constants.Colors.grayScale200)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
    }
    
    private var post : some View {
        LazyVStack {
            PostListView(profileImage: UIImage(named: "cat")!, userNickName: "막내", createdTime: "2시간전", content: "시간 있을 때 또 한번\n가족여행 다녀오면 좋을 것 같아\n어떤 여행지가 좋을까!?", great: 3, comment: 8, tags: ["엄마","아빠","누나"])
                .padding(.horizontal, 16)
            PostImageView(profileImage: UIImage(named: "profile-test")!, userNickName: "아빠", createdTime: "6시간전", content: "저번 가족여행 사진이야", great: 4, comment: 2, tags: ["엄마","아빠","누나"])
//            ForEach(1...10, id: \.self) { count in
//                PostListView()
//            }
        }
    }
    
    
    private var plusBotton: some View {
    
        Button {
            pressPlusButton.toggle()
            
        } label: {
            Image("plus")
                .resizable()
                .frame(width: 48, height: 48)
            
        }
        
        .frame(width: 64, height: 64)
        .background(Color(.white))
        .foregroundColor(Constants.Colors.main400)
        .clipShape(Circle())
        .padding()
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
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
