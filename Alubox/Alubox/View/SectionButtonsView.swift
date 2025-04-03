import SwiftUI

struct SectionButtonsView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        VStack(spacing: 0) {
            SectionButton(title: "Controls", icon: "switch.2") {
                withAnimation(.easeOut(duration: 0.5)) {
                    viewModel.activeSection = .controls
                }
            }
            Divider().background(Color.white.opacity(0.2))

            SectionButton(title: "Climate", icon: "fan.fill") {
                withAnimation(.easeOut(duration: 0.5)) {
                    viewModel.activeSection = .climate
                }
            }

            Divider().background(Color.white.opacity(0.2))

            SectionButton(title: "Location", icon: "location.fill") {}
            Divider().background(Color.white.opacity(0.2))

            SectionButton(title: "Inventory", icon: "list.clipboard.fill") {}
            Divider().background(Color.white.opacity(0.2))

            SectionButton(title: "Specifications And Warranty", icon: "info.circle.fill") {}
        }
    }
}
