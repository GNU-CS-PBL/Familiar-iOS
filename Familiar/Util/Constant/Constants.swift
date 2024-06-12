//
//  Constants.swift
//  Familiar
//
//  Created by 준호 on 5/17/24.
//

import SwiftUI

/// Constants - 공통으로 사용되는 상수 값 관리
struct Constants {
    // MARK: - padding
    
    // MARK: - Font
    
    // MARK: - Color
    enum Colors {
        static let main50 = Color(red: 250/255, green: 250/255, blue: 255/255)
        static let main100 = Color("Main100")
        static let main200 = Color("Main200")
        static let main300 = Color("Main300")
        static let main400 = Color("Main400")
        
        static let grayScale50 = Color("GrayScale50")
        static let grayScale100 = Color("GrayScale100")
        static let grayScale200 = Color("GrayScale200")
        static let grayScale300 = Color("GrayScale300")
        static let grayScale400 = Color("GrayScale400")
        static let grayScale500 = Color("GrayScale500")
        static let grayScale600 = Color("GrayScale600")
        static let grayScale700 = Color("GrayScale700")
        static let grayScale800 = Color("GrayScale800")
        static let grayScale900 = Color("GrayScale900")
        
        static let error = Color("Error")
        static let success = Color("Success")
    }
    
    // MARK: - URL 주소
    
    // MARK: - 애니메이션 시간 (스플래쉬 등)
    
    // MARK: - 공용 컴포넌트
    /// 밑 코드들은 타 파일로 통폐합 후 Constants에서 제거될 예정
    struct CustomTextFieldWithBottomLine: View {
        @Binding private var text: String
        @FocusState private var isFocused: Bool
        var maxTextLength: Int
        
        var placeholder: String
        var placeholderimage: String?
        
        init(_ text: Binding<String>, placeholder: String, placeholderimage: String? = nil, maxTextLength: Int = 0) {
            self._text = text
            self.placeholder = placeholder
            self.placeholderimage = placeholderimage
            self.maxTextLength = maxTextLength
        }
        
        var body: some View {
            HStack(alignment: .center, spacing: 6) {
                TextField(placeholder, text: $text)
                    .focused($isFocused)
                    .font(Font.custom("Pretendard", size: 18))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, 0)
                    .padding(.trailing, 8)
                    .padding(.vertical, 12)
                    .frame(width: 270, height: 26, alignment: .leading)
                    .background(.white)
                
                if maxTextLength != 0 {
                    Text("\(text.count) / \(maxTextLength)")
                        .foregroundColor(Constants.Colors.grayScale500)
                }
                    
                //                .foregroundColor(.PrimaryOrange300)
                
                if let placeholderImage = placeholderimage, !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(placeholderImage)
                            .frame(width: 24, height: 24)
                    }.offset(x: -30)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? Constants.Colors.main300 : Constants.Colors.grayScale300, lineWidth: 1)
                    .frame(height: 0.5)
                    .offset(y: 18)
            )
            .frame(width: 335)
            .accentColor(Constants.Colors.main300)
//            .onChange(of: text) { oldValue, newValue in
//                if newValue.count > maxTextLength && maxTextLength != 0 {
//                    self.text = oldValue
//                }
//            }
        }
    }


    struct CustomTextFieldTest: View {
        @State private var text: String = ""
        @FocusState private var isFocused: Bool

        var placeholder: String
        var placeholderimage: String?
        
        init(placeholder: String, placeholderimage: String? = nil) {
             self.placeholder = placeholder
             self.placeholderimage = placeholderimage
         }
       
        var body: some View {
            
            HStack(alignment: .center, spacing: 6) {
                
                TextField(placeholder, text: $text)
                  .font(Font.custom("Pretendard", size: 14))
                  .foregroundColor(Constants.Colors.grayScale500)
                  
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 8)
            .frame(width: 343, height: 46, alignment: .leading)
            .background(.white)
            .overlay(
                Rectangle()
                .inset(by: 0.5)
                .offset(y: 18)
                .stroke(Constants.Colors.main300, lineWidth: 1)
                .frame(height: 1)
            )
                
            
            .accentColor(Constants.Colors.main300)
        }
    }


    struct CustomTextFieldTest_Previews: PreviewProvider {
        static var previews: some View {
            CustomTextFieldTest(placeholder: "이메일을 입력하세요")
        }
    }

    struct BaseOnlyRectangleView: View {
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .frame(width: geometry.size.width, height: geometry.size.height / 2) // Adjust the height as needed
                        .foregroundColor(Color.blue) // Color of the base

                    Rectangle() // Transparent mask to hide the upper part
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .foregroundColor(Color.clear)
                        .mask(
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .black]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
            }
        }
    }
    
    struct ProfileButton: View {
        var image: String
        
        var body: some View {
            ZStack(alignment: .bottomTrailing) {
                HStack(alignment: .center, spacing: 0) {
                    Image(image)
                        .resizable()
                        .frame(width: 78.75, height: 78.75)
                        .zIndex(1)
                }
                .padding(.horizontal, 5.625)
                .padding(.top, 16.875)
                .padding(.bottom, 0)
                .frame(width: 90, alignment: .center)
                .background(Constants.Colors.main100)
                .cornerRadius(100)
                .overlay(
                RoundedRectangle(cornerRadius: 100)
                .inset(by: 0.5)
                .stroke(Constants.Colors.main100, lineWidth: 1)
                )
                
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "pencil")
                        .fontWeight(.bold)
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                
                .padding(7)
                .frame(width: 32, height: 32, alignment: .center)
                .background(Constants.Colors.main300)
                .clipped()
                .clipShape(Circle())
                .overlay(
                    RoundedRectangle(cornerRadius: 36)
                        .inset(by: 1)
                        .stroke(.white, lineWidth: 2)
                )
//                .offset(x: 30,y: 30)
            }
        }
    }
}
