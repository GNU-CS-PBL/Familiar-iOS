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
                            .font(Font.custom("pretendard", size: 16).weight(.semibold))
//                            .font(.system(size: 16, weight: .medium))
                        
                            .foregroundColor(Constants.Colors.grayScale800)
                        //                            .padding(.leading,24)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("등록")
//                            .font(.system(size: 16, weight: .semibold))
                            .font(Font.custom("pretendard", size: 16).weight(.semibold))
                            .foregroundColor(feedWriteZone == "" ? Constants.Colors.grayScale500 : Constants.Colors.main400)
                    }
                    .disabled(feedWriteZone == "")
                }
                
                .padding(.vertical, 19)
                .padding(.bottom, 22)
                
                HStack(spacing: 2){
                    
                    Text("본문")
                        .font(Font.custom("pretendard", size: 16).weight(.medium))
                    
                    Text("*")
                        .font(Font.custom("pretendard", size: 12))
                        .foregroundColor(.red)
                }
                .font(Font.custom("pretendard", size: 22).weight(.medium))
                .padding(.bottom, 12)
                
                
                ZStack(alignment: .topLeading) {
                    
                    let placeholder : String = "텍스트를 입력하세요."
                    
                    TextEditor(text: $feedWriteZone)
//                        .scrollContentBackground(.hidden)
                        .padding(.top, 3)
                        .padding(.leading, 10)
                        .frame(minHeight: 400)
                        .font(Font.custom("pretendard", size: 18))
//                        .background(Constants.Colors.grayScale200)
                        .cornerRadius(4)
                    
                    if feedWriteZone.isEmpty {
                        Text(placeholder)
                            .foregroundColor(Constants.Colors.grayScale500)
                            .padding(.leading, 12)
                            .padding(.top, 12)
                            .font(Font.custom("pretendard", size: 18))
                    }
                } // : ZStack
                .padding(.bottom, 24)

                
                Text("사진 / 영상")
                    .font(Font.custom("pretendard", size: 16).weight(.semibold))
                    .padding(.bottom, 12)
                if images == [] {
                    Button {
                        showPhotoPicker = true
                    } label: {
                        HStack {
                            Spacer()
                        Text("사진 / 영상 추가")
                            .foregroundColor(Constants.Colors.grayScale700)
                            .font(Font.custom("pretendard", size: 16).weight(.bold))
                        
                        Spacer()
                    }
                    .frame(height: 62)
                    .background(Constants.Colors.grayScale200)
                    .cornerRadius(8)
                }
                } else {
                    HStack(alignment: .center) {
                        Button {
                            showPhotoPicker = true
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))
                                Text("사진을 등록하세요!")
                                    .font(Font.custom("pretendard", size: 12))
                                
                            }
                            .frame(width: 160, height: 160)
                            .foregroundColor(Constants.Colors.grayScale500)
                            .background(Constants.Colors.grayScale100)
                            .cornerRadius(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Constants.Colors.grayScale300, lineWidth: 1)
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
                    .padding(.horizontal, -16)
                }
                
                HStack {
                    Text("태그")
                        .font(Font.custom("pretendard", size: 16).weight(.semibold))
                    
                    Spacer()
                    if tagInfo != [] {
                        Button {
                            pressAddTagButton.toggle()
                        } label: {
                            Text("수정")
                                .font(.custom("pretendard", size: 14))
                                .foregroundColor(Constants.Colors.main400)
                        }
                    }
                }
                .padding(.top, 34)
                
                HStack(alignment: .top, spacing: 0) {
                    Image("tag")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top, 10)
                        .padding(.trailing, 16)
                    
                    if tagInfo == [] {
                        Button {
                            pressAddTagButton.toggle()
                        } label: {
                            Image("person_outline")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Text("구성원 추가 +")
                                .font(Font.custom("pretendard", size: 16))
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
                                self.generateContent(in: geometry, totalHeight: $totalHeight)

                            }
                        }
                        .frame(height: totalHeight)
                    }
                }
           
            } // : VStack
            .padding(.horizontal, 24)
            .photoPicker(isPresented: $showPhotoPicker, selection: $images)
//                        .sheet(isPresented: $pressAddTagButton, content: {
//                            TagSheetView(tagInfo: $tagInfo)
//                                .presentationDetents([.medium])
//                                .presentationCornerRadius(25)
//                        })
            
            .fullScreenCover(isPresented: $pressAddTagButton) {
                TagSheetView(tagInfo: $tagInfo)
                    .cornerRadius(25) 
            }

        }
        
    }
func generateContent(in g: GeometryProxy, totalHeight: Binding<CGFloat>) -> some View {
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
                        width = 0 // 마지막 항목
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if tag == self.tagInfo.last! {
                        height = 0 // 마지막 항목
                    }
                    return result
                })
        }
    }
    .background(viewHeightReader(totalHeight))
}

    
    func item(for tag: TagInfo) -> some View {
        HStack {
            Image(uiImage: tag.image)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(.circle)
            Text(tag.nickName)
                .foregroundColor(Constants.Colors.grayScale800)
                .font(Font.custom("pretendard", size: 16))
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



