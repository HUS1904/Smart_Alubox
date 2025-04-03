import SwiftUI

struct SectionButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .gray)
                    .font(.system(size: 25, weight: .regular))

                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray)
                    .font(.system(size: 15, weight: .bold))
            }
            .padding(.vertical)
            .padding(.horizontal, 16)
        }
    }
}
