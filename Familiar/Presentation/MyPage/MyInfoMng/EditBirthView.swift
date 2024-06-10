//
//  EditBirthView.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//
import SwiftUI

// MARK: - State
struct EditBirthView {
    @Environment(\.presentationMode) var presentationMode
    @State var isActive = false
    @State var isError = false
    @State var isSuccess = false /// API 연동 시작시 false로 변경
    
    @State var year = ""
    @State var month = ""
    @State var day = ""
}

// MARK: - View
extension EditBirthView: View {
    var body: some View {
        VStack {
            explnTitle
            StdBirthField(year: $year, month: $month, day: $day, isError: $isError, onDateChanged: checkDateValidity)
            explnText
            Spacer()
            checkButton
        }
        .padding(.top, 40)
        .padding(.horizontal, 24)
    }
}

// MARK: - View Detail
extension EditBirthView {
    private var explnTitle: some View {
        HStack {
            Text("생일")
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.46))
            Spacer()
        }
    }
    
    private var explnText: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack(spacing: 3) {
                Text("※ 생일을 재설정하면")
                    .font(Font.custom("Pretendard-Regular", size: 14))
                    .foregroundColor(Color.grayScale600)
                Text("3달간 변경할 수 없습니다.")
                    .font(Font.custom("Pretendard-Regular", size: 14))
                    .foregroundColor(Color.main200)
            }
            .padding(.top, 16)
            
            HStack {
                if(isError) {
                    Text("올바른 날짜를 기입해주세요.")
                        .font(Font.custom("Pretendard-Regular", size: 14))
                        .foregroundColor(Color.error)
                }
            }
        }
    }
    
    private var checkButton: some View {
        Button(action: {
            if isActive {
                //api 호출
                // api 여부 성공시 isSuccess true
                isSuccess = true
                if isSuccess {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }) {
            Text("완 료")
                .font(.headline).bold()
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundColor(.white)
                .background(isActive ? Color.main300 : Color.grayScale200)
                .cornerRadius(10)
        }
        .padding(.bottom, 42)
        .disabled(!isActive)
    }
}

// MARK: - Function
extension EditBirthView {
    private func checkDateValidity() {
        if !year.isEmpty && !month.isEmpty && !day.isEmpty && !isError {
            isActive = true
        } else {
            isActive = false
        }
    }
}

// MARK: - Preview
struct EditBirthView_Previews: PreviewProvider {
    static var previews: some View {
        EditBirthView()
    }
}
