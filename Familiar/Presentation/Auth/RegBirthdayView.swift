//
//  RegBirthdayView.swift
//  Familiars
//
//  Created by 준호 on 3/16/24.
//

import SwiftUI

// MARK: - State
struct RegBirthdayView {
    @Binding var userData: RegRequestDto
    
    @State var year = ""
    @State var month = ""
    @State var day = ""
    
    @State var isActive = false
    @State var isComplete = false
    @State var isError = false
    @State var isSuccess = true /// API 연동 시작시 false로 변경
    
    let mainText = "테스터 님의 생일을\n알려주세요."
    let subText  = "방 구성원들에게 알려줄 수도 있어요!"
    @State private var errorMessage: String?
    
    let topPadding: CGFloat = Constants.Paddings.regTop
    let BottomPadding: CGFloat = Constants.Paddings.regBottom
    let horizontalPadding: CGFloat = Constants.Paddings.regHorizontal
}

// MARK: - Frame
extension RegBirthdayView: View {
    var body: some View {
        VStack {
            RegExplnTitle(mainText: mainText, subText: subText)
            if (isError) {
                ErrorMessageText(errorMessage: errorMessage)
            }
            StdBirthField(year: $year, month: $month, day: $day, isError: $isError, onDateChanged: checkDateValidity)
                .padding(.top, 155)
            Spacer()
            nextButton
        }
        .padding(.top, topPadding)
        .padding(.bottom, BottomPadding)
        .padding(.horizontal, horizontalPadding)
    }
}

// MARK: - View Detail
extension RegBirthdayView {
    private var nextButton: some View {
        Button(action: {
            userData.birth = "\(year)-\(month)-\(day)"
            isActive = true
        }) {
            Text("다 음")
                .font(.headline).bold()
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundColor(.white)
                .background(isComplete ? Color.main300 : Color.grayScale200)
                .cornerRadius(10)
        }
        .padding(.bottom, 42)
        .disabled(!isComplete) // 비활성화 조건 명시
        .background(
            CustomNavLink(destination: RegProfileView(userData: $userData)
                           ,isActive: $isActive) {
                EmptyView()
            }
        )
    }
}

// MARK: - Function
extension RegBirthdayView {
    private func checkDateValidity() {
        if !year.isEmpty && !month.isEmpty && !day.isEmpty && !isError {
            isComplete = true
            isError = false
        } else {
            isComplete = false
            isError = true
            errorMessage = "올바른 날짜를 기입해 주세요."
        }
    }
}

// MARK: - Preview
struct RegBirthdayView_Previews: PreviewProvider {
    @State static var testData = RegRequestDto(provider: "123", accessToken: "123", name: "test", image: "cat", birth: "", marketingAgree: false, field2: false)
    
    static var previews: some View {
        RegBirthdayView(userData: $testData)
    }
}
