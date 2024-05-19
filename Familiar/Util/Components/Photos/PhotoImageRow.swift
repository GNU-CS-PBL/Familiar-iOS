import SwiftUI

struct PhotoImageRow: View {
    var image: UIImage
    var action: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFill()
                .cornerRadius(8)
            Button(action: action) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(
                        width: 14,
                        height: 14
                    )
                    .padding(5)
                    .background(Color(white: 0, opacity: 0.4))
                    .clipShape(.circle)
                    .foregroundColor(.white)
            }
            .padding([.top, .trailing], 5)
        }
        .frame(width: 100, height: 100)
    }
}


#Preview {
    PhotoImageRow(
        image: UIImage(systemName: "person.fill")!,
        action: { }
    )
}
