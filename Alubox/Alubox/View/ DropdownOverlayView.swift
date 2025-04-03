import SwiftUI

struct DropdownOverlayView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        VStack {
            Spacer()
            Text("Dropdown Menu UI Placeholder")
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 4)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).ignoresSafeArea())
        .onTapGesture {
            viewModel.toggleDropdown()
        }
    }
}

