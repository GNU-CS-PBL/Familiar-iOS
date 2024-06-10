import SwiftUI

// MARK: - State
struct MyPageView {
    @State var nickname = "테스터"
    @State var profilename = "진짜이룸"
    @State var isAdmin = false
    @State private var showLeaveConfirmation = false
    @State private var showAdminErrorAlert = false
    @State private var leaveStatus: LeaveStatus? = nil
    
    var invtNum = 5
}

// MARK: - View
extension MyPageView: View {
    var body: some View {
        VStack(spacing: 0) {
            profile
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            
            Rectangle()
                .frame(height: 8)
                .foregroundColor(Constants.Colors.grayScale50)
            
            // 일반 항목들
            MyPageElementView(menuTitle: "내 정보관리", emphs: false) {
                MyInfoMngView()
            }.overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
            
            MyPageElementView(menuTitle: "게시물 / 댓글관리", emphs: false) {
                MyContentMngView()
            }.overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
            
            if isAdmin {
                MyPageMngElement(menuTitle: "방 관리", invtNum: invtNum) {
                    RoomMngView()
                }.overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
            } else {
                MyPageElementView(menuTitle: "방 코드 확인", emphs: false) {
                    RoomCodeView()
                }.overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
            }
            
            leaveRoomButton
            Rectangle()
                .frame(height: 8)
                .foregroundColor(Constants.Colors.grayScale50)
            
            MyPageElementView(menuTitle: "오픈소스 라이선스", emphs: false) {
                WebConnecter(urlToLoad: "https://ryuwon-project.notion.site/7cb09f3ed61b413fbf1fedcdf5a8c0f0?pvs=4")
            }.overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
            
            MyPageElementView(menuTitle: "개인정보 처리방침", emphs: false) {
                WebConnecter(urlToLoad: "https://ryuwon-project.notion.site/58c10d0c1b7d4cc28394c58190b6088e")
            }.overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
            
            MyPageElementView(menuTitle: "서비스 이용약관", emphs: false) {
                WebConnecter(urlToLoad: "https://ryuwon-project.notion.site/2170e59a6df64493b714da3c843793ba")
            }
            Spacer()
            appVersion
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
        }
        .padding(.top, 58)
        .alert(isPresented: $showAdminErrorAlert) {
            Alert(
                title: Text("탈퇴 오류")
                    .font(.custom("Pretendard", size: 20))
                    .foregroundColor(.red),
                message: Text("방장 권한이 남아 있어 탈퇴가 불가능합니다.\n권한을 위임하고 다시 시도해주세요."),
                dismissButton: .default(Text("확인"))
            )
        }
        .alert(isPresented: $showLeaveConfirmation) {
            Alert(
                title: Text("방 퇴장하기")
                    .font(.custom("Pretendard", size: 20))
                    .foregroundColor(.red),
                message: Text("정말 방을 탈퇴하시겠습니까?"),
                primaryButton: .default(Text("네"), action: {
                    leaveStatus = .success
                }),
                secondaryButton: .cancel(Text("아니요"))
            )
        }
        .alert(item: $leaveStatus) { status in
            switch status {
            case .success:
                return Alert(
                    title: Text("탈퇴 성공")
                        .font(.custom("Pretendard", size: 20))
                        .foregroundColor(.red),
                    message: Text("성공적으로 탈퇴가 되었습니다."),
                    dismissButton: .default(Text("확인"))
                )
            case .failure:
                return Alert(
                    title: Text("탈퇴 오류")
                        .font(.custom("Pretendard", size: 20))
                        .foregroundColor(.red),
                    message: Text("문제가 생겨 탈퇴가 성공적으로 진행되지 못하였습니다."),
                    dismissButton: .default(Text("확인"))
                )
            }
        }
    }
}

// MARK: - View Detail
extension MyPageView {
    private var profile: some View {
        HStack(alignment: .center, spacing: 10) {
            ZStack {
                HStack(alignment: .center, spacing: 0) {
                    Image("profile-default")
                        .resizable()
                        .frame(width: 42.75, height: 42.75)
                        .zIndex(1)
                }
                .padding(.horizontal, 5.625)
                .padding(.horizontal, 3.375)
                .padding(.top, 10.125)
                .padding(.bottom, 0)
                .frame(width: 54, alignment: .center)
                .background(Constants.Colors.main100)
                .cornerRadius(100)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(nickname)
                    .font(Font.custom("Pretendard", size: 20).weight(.semibold))
                    .foregroundColor(Color(red: 0.12, green: 0.13, blue: 0.13))
                Text(profilename)
                    .font(Font.custom("Pretendard", size: 14).weight(.medium))
                    .foregroundColor(Constants.Colors.grayScale500)
            }
            Spacer()
        }
    }
    
    private var leaveRoomButton: some View {
        Button(action: {
            if isAdmin {
                showAdminErrorAlert = true
            } else {
                showLeaveConfirmation = true
            }
        }) {
            HStack {
                Text("방 퇴장하기")
                    .font(Font.custom("Pretendard", size: 16).weight(.medium))
                    .foregroundColor(Color(red: 0.99, green: 0.28, blue: 0.28).opacity(0.9))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Image("chevron-forward")
                    .frame(width: 20, height: 20)
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
            .background(Color.white)
        }
        .overlay(Rectangle().stroke(Constants.Colors.grayScale50, lineWidth: 1))
    }
    
    private var appVersion: some View {
        HStack {
            Text("앱 버전 v1.0.0")
              .font(Font.custom("Pretendard-Regular", size: 11))
              .foregroundColor(Color.grayScale500)
            Spacer()
        }
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
