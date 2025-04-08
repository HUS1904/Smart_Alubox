import SwiftUI

struct QuickActionsRowView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        HStack(spacing: 0) {
            ToggleButton(
                title: "Lock",
                systemImage: "lock.fill",
                isActive: viewModel.alubox.isLocked
            ) {
                viewModel.toggleLock()
            }
            .disabled(!viewModel.bluetoothManager.isReady) // ⬅️ Now it will update

            Spacer()

            ToggleButton(
                title: "Climate",
                systemImage: "fan.fill",
                isActive: viewModel.alubox.fanOn
            ) {
                viewModel.toggleFan()
            }

            Spacer()

            ToggleButton(
                title: "Lights",
                systemImage: "lightbulb.fill",
                isActive: viewModel.alubox.lightsOn
            ) {
                viewModel.toggleLights()
            }
        }
        .padding(.horizontal, 75)
    }
}
