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
//    @State var tagInfoList: [TagInfo] = [
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 0),
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 1),
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 2),
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 3),
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 4),
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 5),
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 6),
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 7),
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 8),
//        .init(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: 9)
//    ]
    
    @State var tagInfoList: [TagInfo] = (0...9).map{
        TagInfo(image: UIImage(named: "cat")!, nickName: "냥냥이", isPressProfile: false, id: $0)
    }
    

    // 3행 그리드 아이템
    var gridLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // sheet 드래그 부분
            ZStack(alignment: .top){
                VStack(spacing: 7) {
                    RoundedRectangle(cornerRadius: 3)
                        .foregroundColor(Constants.Colors.grayScale800.opacity(0.3))
                        .frame(width: 36, height: 5)
                        .padding(.top, 4)
                        .padding(.bottom, 5)
                    Text("태그 추가")
                        .font(.custom("pretendard", size: 18))
//                        .bold()
                    
                }
                HStack {
                    
                    
                    Spacer()
                    Button {
                        // Sheet 닫기 Action
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Constants.Colors.grayScale800.opacity(0.6))
                            .font(.body.bold())
                            .frame(width: 30, height: 30)
                            .background(Constants.Colors.grayScale500.opacity(0.1))
                            .clipShape(Circle())
                    }
                    .padding(.top, 17)
                }
                
            } // : ZStack
            .padding(.horizontal, -16)
            .padding(.bottom, 20)
            
            ScrollView {
                
                LazyVGrid(columns: gridLayout) {
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
//                    .font(.headline).bold()
                    .font(Font.custom("pretendard", size: 16).weight(.semibold))
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .foregroundColor(.white)
                    .background(tagInfoList.first { $0.isPressProfile == true } == nil ? Constants.Colors.grayScale300 : Constants.Colors.main200)
                    .cornerRadius(10)
                //                .padding(.horizontal, 24)
            }
            .disabled(tagInfoList.first { $0.isPressProfile == true } == nil)
        }
        
        .padding(.horizontal, 27)
    }
}

#Preview {
    TagSheetView(tagInfo: .constant([]))
}
