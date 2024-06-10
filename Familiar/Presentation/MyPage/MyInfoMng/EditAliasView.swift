//
//  EditAliasView.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

// MARK: - State
struct EditAliasView {
    //    @StateObject private var authVM = AuthVM()
    @Environment(\.presentationMode) var presentationMode
    
    @State var alias = ""
    @State var isError = false
    @State var isActive = false
    @State var isSuccess = true /// API 연동 시작시 false로 변경
    @FocusState private var isTextFieldFocused: Bool
}

// MARK: - View
extension EditAliasView: View {
    var body: some View {
        VStack {
            explnTitle
            aliasField
            explnText
            Spacer()
            checkButton
        }
        .padding(.horizontal, 24)
    }
}

// MARK: - View Detail
extension EditAliasView {
    private var explnTitle: some View {
        HStack {
            Text("별칭")
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.46))
            Spacer()
        }
        .padding(.top, 36)
    }
    
    private var aliasField: some View {
        StdTextField(text: $alias, maxLength: 10, placeholder: "별칭를 입력하세요")
            .focused($isTextFieldFocused)
            .padding(.top, 4)
            .onChange(of: alias) { _ in
                checkAliasValidity()
            }
    }
    
    private var explnText: some View {
        VStack(spacing: 8) {
            HStack(spacing: 3) {
                Text("※ 별칭을 변경하면")
                    .font(Font.custom("Pretendard-Regular", size: 14))
                    .foregroundColor(Color.grayScale600)
                Text("10일간 변경할 수 없습니다.")
                    .font(Font.custom("Pretendard-Regular", size: 14))
                    .foregroundColor(Color.main200)
                Spacer()
            }
            
            HStack {
                if(isError) {
                    Text("이미 해당 별칭이 존재합니다.")
                        .font(Font.custom("Pretendard-Regular", size: 14))
                        .foregroundColor(Color.error)
                }
                Spacer()
            }
        }
        .padding(.top, 16)
    }
    
    private var checkButton: some View {
        Button(action: {
//            authVM.nickNameValidate(nickname: nickname)
//            authVM.taskError.sink { errMsg in /// 오류 시
//                print(errMsg)
//                isError = true
//            }
//            .store(in: &authVM.subscription)
//            authVM.taskSuccess.sink { /// 성공 시
//                print("셍공")
//                isError  = false
//                /// 성공 시 뒤로가기 로직
//            }
//            .store(in: &authVM.subscription)
            if isSuccess {
                presentationMode.wrappedValue.dismiss()
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
        .disabled(!isActive)
    }
}

// MARK: - Function
extension EditAliasView {
    private func checkAliasValidity() {
        isActive = !alias.isEmpty
    }
}

// MARK: - Preview
struct EditAliasViewView_Previews: PreviewProvider {
    static var previews: some View {
        EditAliasView()
    }
}
