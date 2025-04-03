import SwiftUI

struct HeroImageView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .padding(.horizontal)
            .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 30)
    }
}
