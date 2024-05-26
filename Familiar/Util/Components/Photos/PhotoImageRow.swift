import SwiftUI

struct PhotoImageRow: View {
    var image: UIImage
    var action: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .frame(width: 160, height: 160)
                .scaledToFill()
                .cornerRadius(8)
            Button(action: action) {
                Image(systemName: "xmark")
                    .font(.system(size: 12).bold())
                    .foregroundColor(.white)
                    .frame(
                        width: 28,
                        height: 28
                    )
//                    .padding(5)
                    .background(Constants.Colors.grayScale500.opacity(0.3))
                    .clipShape(.circle)
//                    .foregroundColor(.white)
            }
            .padding([.top, .trailing], 5)
        }
//        .frame(width: 100, height: 100)
    }
}


#Preview {
    PhotoImageRow(
        image: UIImage(systemName: "person.fill")!,
        action: { }
    )
}
