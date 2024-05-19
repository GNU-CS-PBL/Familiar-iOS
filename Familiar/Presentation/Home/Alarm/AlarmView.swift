//
//  AlertView.swift
//  practice
//
//  Created by 박예진 on 3/15/24.
//

import SwiftUI

struct AlarmView: View {
    @StateObject var viewModel = AlarmVM()
    @State var pressAlarmArea : Bool = false
    @State var selectedAlarm: [String] = []
    
    @State var alarmText : [String] = [
        "알림이 왔어욥", "예시입니다", "최대 2줄입니다.최대 2줄입니다.최대 2줄입니다.최대 2줄입니다.최대 2줄입니다.최대 2줄입니다.최대 2줄입니다."
    ]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(alarmText, id : \.self) { index  in
                    AlarmListView(
                        isSelected: .constant(selectedAlarm.contains { $0 == index }),
                        alarmText:index
                    )
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        if !selectedAlarm.contains(where: { $0 == index }) {
                            selectedAlarm.append(index)
                        }
                    }
                    
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .navigationTitle("알림")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: backButton, trailing:  allReadButton)
            .environment(\.locale, Locale(identifier: "ko_kr"))
        }
        .navigationBarBackButtonHidden()
    }
    
    // 함수
    func delete(indexSet: IndexSet) {
        alarmText.remove(atOffsets: indexSet)
    }
    
    // 모두 읽기 버튼
    
    var allReadButton : some View {
        Button {
            selectedAlarm = alarmText
        } label: {
            Text("모두 읽기")
                .bold()
                .foregroundColor(Constants.Colors.main400)
        }
    }
    var backButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 10, height: 16)
                .foregroundColor(.black)
                .padding()
        }
    }
    
    
    
    
    
}



#Preview {
    AlarmView()
}
