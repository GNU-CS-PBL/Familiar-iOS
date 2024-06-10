//
//  StdBirthField.swift
//  Familiar
//
//  Created by 준호 on 6/11/24.
//

import SwiftUI

struct StdBirthField: View {
    @Binding var year: String
    @Binding var month: String
    @Binding var day: String
    @Binding var isError: Bool
    var onDateChanged: (() -> Void)?

    var body: some View {
        HStack(alignment: .center) {
            TextField("1988", text: $year)
                .font(Font.custom("Pretendard-Regular", size: 18))
                .keyboardType(.asciiCapableNumberPad)
                .foregroundColor(Color.grayScale900)
                .multilineTextAlignment(.center)
                .onChange(of: year, perform: { newValue in
                    if newValue.count > 4 {
                        year = String(newValue.prefix(4))
                    }
                    validateDate()
                    onDateChanged?()
                })
            Text("/")
                .font(Font.custom("Pretendard-Regular", size: 24))
                .foregroundColor(Color.grayScale500)
            TextField("11", text: $month)
                .font(Font.custom("Pretendard-Regular", size: 18))
                .keyboardType(.asciiCapableNumberPad)
                .foregroundColor(Color.grayScale900)
                .multilineTextAlignment(.center)
                .onChange(of: month, perform: { newValue in
                    if newValue.count > 2 {
                        month = String(newValue.prefix(2))
                    }
                    validateDate()
                    onDateChanged?()
                })
            Text("/")
                .font(Font.custom("Pretendard-Regular", size: 24))
                .foregroundColor(Color.grayScale500)
            TextField("24", text: $day)
                .font(Font.custom("Pretendard-Regular", size: 18))
                .keyboardType(.asciiCapableNumberPad)
                .foregroundColor(Color.grayScale900)
                .multilineTextAlignment(.center)
                .onChange(of: day, perform: { newValue in
                    if newValue.count > 2 {
                        day = String(newValue.prefix(2))
                    }
                    validateDate()
                    onDateChanged?()
                })
        }
    }
    
    private func validateDate() {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        guard let currentYear = components.year,
              let currentMonth = components.month,
              let currentDay = components.day else {
            isError = true
            return
        }
        
        guard let yearInt = Int(year), yearInt >= 1900, yearInt <= currentYear,
              let monthInt = Int(month), monthInt >= 1, monthInt <= 12,
              let dayInt = Int(day), dayInt >= 1 else {
            isError = true
            return
        }
        
        if yearInt == currentYear {
            if monthInt > currentMonth || (monthInt == currentMonth && dayInt > currentDay) {
                isError = true
                return
            }
        }
        
        let isValidDay: Bool
        switch monthInt {
        case 1, 3, 5, 7, 8, 10, 12:
            isValidDay = dayInt <= 31
        case 4, 6, 9, 11:
            isValidDay = dayInt <= 30
        case 2:
            if yearInt % 4 == 0 && (yearInt % 100 != 0 || yearInt % 400 == 0) {
                isValidDay = dayInt <= 29 // Leap year
            } else {
                isValidDay = dayInt <= 28
            }
        default:
            isValidDay = false
        }
        
        isError = !isValidDay
    }
}

struct StdBirthField_Previews: PreviewProvider {
    static var previews: some View {
        StdBirthField(year: .constant(""), month: .constant(""), day: .constant(""), isError: .constant(false))
    }
}
