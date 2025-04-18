import SwiftUI

struct ToggleButton: View {
    let title: String
    let systemImage: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .symbolRenderingMode(.palette)
                .foregroundStyle(isActive ? Color(.white) : Color(.gray), .blue)
                .font(.system(size: 25, weight: .bold))
        }
    }
}
