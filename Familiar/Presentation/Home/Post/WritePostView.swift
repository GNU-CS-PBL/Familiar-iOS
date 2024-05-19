import SwiftUI

struct WritePostView: View {
    
    @Environment(\.presentationMode) var mode
    @State private var feedWriteZone = ""
    @State private var pressAddTagButton = false
    @Binding var userProfileImage : UIImage
    @State private var isEditing: Bool = false
    @State var showPhotoPicker: Bool = false
    @State var images: [UIImage] = []
    @State var tagInfo: [TagInfo] = []
    @State private var totalHeight = CGFloat.zero
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Text("취소")
                            .font(.title3)
                            .foregroundColor(Constants.Colors.grayScale700)
//                            .padding(.leading,24)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("등록")
                            .font(.title3)
                            .foregroundColor(feedWriteZone == "" ? Constants.Colors.grayScale500 : Constants.Colors.main400)
                    }
                    .disabled(feedWriteZone == "")
                }
                
                Text("본문")
                    .font(.system(size: 22, weight: .medium))
                    .padding(.top, 30)
            
                
                ZStack(alignment: .topLeading) {
                    
                    let placeholder : String = "텍스트를 입력하세요."
                    
                    TextEditor(text: $feedWriteZone)
//                        .scrollContentBackground(.hidden)
                        .padding(.top, 3)
                        .padding(.leading, 10)
                        .frame(minHeight: 400)
                        .font(.system(size: 18))
                        .background(Constants.Colors.grayScale200)
                        .cornerRadius(5)
                    
                    if feedWriteZone.isEmpty {
                        Text(placeholder)
                            .foregroundColor(Constants.Colors.grayScale500)
                            .padding(.leading, 12)
                            .padding(.top, 12)
                            .font(.system(size: 18))
                    }
                } // : ZStack
                .padding(.top, 12)
                
                Text("사진 / 영상")
                    .font(.system(size: 22, weight: .medium))
                    .padding(.top, 30)
                if images == [] {
                    Button {
                        showPhotoPicker = true
                    } label: {
                        Text("사진 / 영상 추가")
                            .foregroundColor(Constants.Colors.grayScale700)
                            .font(.system(size: 20, weight: .bold))
                            .frame(width: 300, height: 70)
                            .background(Constants.Colors.grayScale200)
                            .cornerRadius(14)
                    }
                    .padding()
                    .padding(.leading, 10)
                } else {
                    HStack(alignment: .center) {
                        Button {
                            showPhotoPicker = true
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "camera")
                                Text("사진을 등록하세요!")
                                    .font(.system(size: 12))
                            }
                            .frame(width: 100, height: 100)
                            .foregroundColor(Constants.Colors.grayScale700)
                            .background(Constants.Colors.grayScale200)
                            .cornerRadius(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Constants.Colors.grayScale700, lineWidth: 1)
                            }
                        }
                        ScrollView(.horizontal) {
                            HStack(spacing: 0) {
                                ForEach(images, id: \.self) { image in
                                    PhotoImageRow(image: image) {
                                        let index = images.firstIndex(of: image)
                                        images.remove(at: index!)
                                    }
                                    .padding(.trailing, 10)
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
                
                HStack {
                    Text("태그")
                        .font(.system(size: 22, weight: .medium))
                    Spacer()
                    if tagInfo != [] {
                        Button {
                            pressAddTagButton.toggle()
                        } label: {
                            Text("수정")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(Constants.Colors.main400)
                        }
                    }
                }
                .padding(.top, 30)
                
                HStack(alignment: .top, spacing: 0) {
                    Image("tag")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding([.top, .trailing, .bottom], 16)
                    
                    if tagInfo == [] {
                        Button {
                            pressAddTagButton.toggle()
                        } label: {
                            Image("person_outline")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Text("구성원 추가 +")
                                .foregroundColor(Constants.Colors.main200)
                               
                            
                        }
                        // 추가 버튼 클릭시 시트 올라옴
                        .frame(width: 170, height: 45)
                        // 뷰를 겹치게 하여 border 설정
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Constants.Colors.main200, lineWidth: 1)
                        )
                        
                    } else {
                        VStack {
                            GeometryReader { geometry in
                                self.generateContent(in: geometry)
                            }
                        }
                        .frame(height: totalHeight)
                    }
                }
                Spacer()
            } // : VStack
            .padding(.horizontal, 20)
            .photoPicker(isPresented: $showPhotoPicker, selection: $images)
//            .sheet(isPresented: $pressAddTagButton, content: {
//                TagSheetView(tagInfo: $tagInfo)
//                    .presentationDetents([.medium])
//                    .presentationCornerRadius(25)
//            })
        }
        
    }
    func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tagInfo, id: \.self) { tag in
                item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tagInfo.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tagInfo.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    func item(for tag: TagInfo) -> some View {
        HStack {
            Image(uiImage: tag.image)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(.circle)
            Text(tag.nickName)
                .foregroundColor(Constants.Colors.grayScale800)
        }
        .padding([.vertical], 5)
        .padding([.horizontal])
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Constants.Colors.grayScale400, lineWidth: 1)
        )
        .padding(.trailing, 5)
    }
    
    func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

#Preview {
    WritePostView(userProfileImage: .constant(UIImage(named: "cat")!))
}
