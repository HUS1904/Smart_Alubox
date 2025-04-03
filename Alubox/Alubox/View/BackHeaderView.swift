import SwiftUI

struct BackHeaderView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeOut(duration: 0.5)) {
                    viewModel.resetView()
                }
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
}
