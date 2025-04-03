import SwiftUI

struct QuickActionsRowView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        HStack(spacing: 0) {
            ToggleButton(
                title: "Lock",
                systemImage: "lock.fill",
                //systemImage: viewModel.alubox.isLocked ? "lock.fill" : "lock.slash.fill",
                isActive: viewModel.alubox.isLocked
            ) {
                viewModel.toggleLock()
            }
            
            Spacer()
            
            
            ToggleButton(
                title: "Climate",
                systemImage: "fan.fill",
                //systemImage: viewModel.alubox.fanOn ? "fan.fill" : "fan.slash.fill",
                isActive: viewModel.alubox.fanOn
            ) {
                viewModel.toggleFan()
            }
            
            Spacer()

            ToggleButton(
                title: "Lights",
                systemImage: "lightbulb.fill",
                //systemImage: viewModel.alubox.lightsOn ? "lightbulb.fill" : "lightbulb.slash.fill",
                isActive: viewModel.alubox.lightsOn
            ) {
                viewModel.toggleLights()
            }
        }
        .padding(.horizontal, 75)
    }
}
