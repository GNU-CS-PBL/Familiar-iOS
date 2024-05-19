import SwiftUI

struct TagInfo: Hashable {
    let image: UIImage
    let nickName: String
    let isPressProfile: Bool
    let id: Int
}

struct TagSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var tagInfo: [TagInfo]
    @State var tagInfoList: [TagInfo] = [
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 0),
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 1),
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 2),
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 3),
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 4),
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 5),
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 6),
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 7),
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 8),
        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 9)
    ]
    

    // 3행 그리드 아이템
    var gridLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
       
        // sheet 드래그 부분
        VStack(spacing :.zero) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(height: 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(.gray)
                        .frame(width: 50, height: 5)
                    )
            
        } // : VStack
        
   
        HStack {
            
            Spacer()
            
            Text("태그 추가")
                .font(.title2)
                .bold()
                .offset(x:25, y: -15)
//                .offset(y: -15)
//
            
            Spacer()
            
            
            
            Button {
                // Sheet 닫기 Action
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "x.circle.fill")
                    .foregroundColor(Constants.Colors.grayScale300)
                    .font(.largeTitle)
                    .offset(x:20, y: -30)
                

                   
            }
            .padding(.trailing)
         
        } // : HStack
        .padding(.horizontal)
        
        
        Spacer()
        
        ScrollView {
        
            LazyVGrid(columns: gridLayout, spacing: 20) {
                ForEach(tagInfoList, id: \.id) { tag in
                    TagProfileView(tagInfo: tag)
                        .onTapGesture {
                            let index = tagInfoList.firstIndex { $0.id == tag.id } ?? 0
                            tagInfoList[index] = .init(
                                image: tag.image,
                                nickName: tag.nickName,
                                isPressProfile: !tag.isPressProfile,
                                id: tag.id
                            )
                        }
                }
            }
        }
        
        
        Button {
            tagInfo = tagInfoList.filter { $0.isPressProfile == true }
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("완료")
                .font(.headline).bold()
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundColor(.white)
                .background(tagInfoList.first { $0.isPressProfile == true } == nil ? Constants.Colors.grayScale300 : Constants.Colors.main300)
                .cornerRadius(10)
                .padding(.horizontal, 24)
        }
        .disabled(tagInfoList.first { $0.isPressProfile == true } == nil)
        
        

        
        
    }
}

#Preview {
    TagSheetView(tagInfo: .constant([]))
}
