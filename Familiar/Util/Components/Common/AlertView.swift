//
//  AlertView.swift
//  Familiar
//
//  Created by 박예진 on 6/12/24.
//

import SwiftUI

struct AlertAction {
    var text: String
    var foregroundColor: Color
    var action: (() -> Void)?
    
    var button: some View {
        Button {
            self.action?()
        } label: {
            Text(self.text)
                .font(Font.custom("Pretendard", size: 17))
                .foregroundColor(self.foregroundColor)
        }
    }
    
    init(text: String,
         foregroundColor: Color = .grayScale500,
         action: (() -> Void)? = nil) {
        self.text = text
        self.foregroundColor = foregroundColor
        self.action = action
    }
    
    func appendAction(_ appendedAction: @escaping ()->Void) -> Self {
        .init(text: text,
              foregroundColor: foregroundColor) {
            appendedAction()
            action?()
        }
    }
}

struct AlertView {
    var title: String
    var titleColor: Color
    var description: String
    var primary: AlertAction
    var secondary: AlertAction?
    
    init(title: String,
         titleColor: Color = .main400,
         description: String,
         primary: AlertAction,
         secondary: AlertAction? = nil) {
        self.title = title
        self.titleColor = titleColor
        self.description = description
        self.primary = primary
        self.secondary = secondary
    }
}

extension AlertView: View {
    var body: some View {
        ZStack(alignment: .center) {
            VStack(spacing: 0) {
                VStack(alignment: .center, spacing: 4) {
                    Text(title)
                        .foregroundColor(self.titleColor)
                        .font(Font.custom("Pretendard", size: 17))
                        .multilineTextAlignment(.center)
                    Text(description)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.grayScale900)
                        .font(Font.custom("Pretendard", size: 13))
                        .lineLimit(2)
                    
                }
                .padding(.vertical, 16)
                Divider()
                    .background(.grayScaleDivider)
                HStack {
                    if let secondary = secondary {
                        VStack(spacing:0)  {
                            secondary.button
                            HStack { Spacer() }
                                .frame(height: 0)
                        }
                        Divider()
                            .background(.grayScaleDivider)
                        VStack(spacing:0) {
                            primary.button
                            HStack { Spacer() }
                                .frame(height: 0)
                        }
                    } else {
                        primary.button
                    }
                    
                }.frame(height: 44)
                
            }
            .frame(width: 260)
            .background(.grayScale50)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 14))
            VStack {
                Spacer()
                HStack { Spacer() }
            }
        }
        .background(.clear)
        .ignoresSafeArea()
    }
}

