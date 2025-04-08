import Foundation
import SwiftUI

enum ActiveSection {
    case none, controls, climate, location, inventory, specifications
}

class MainViewModel: ObservableObject {
    @Published var activeSection: ActiveSection = .none
    @Published var isDropdownOpen = false
    @Published var alubox: Alubox = MockData.sampleBox

    let bluetoothManager = BluetoothManager.shared

    init() {
        print("🔥 MainViewModel created — using shared BluetoothManager")
    }

    func resetView() {
        activeSection = .none
    }

    func toggleLock() {
        guard bluetoothManager.isReady else {
            print("❌ Bluetooth not ready yet")
            return
        }

        alubox.isLocked.toggle()
        let command = alubox.isLocked ? "close" : "open"
        bluetoothManager.writeLockCommand(command)
    }

    func toggleLights() {
        alubox.lightsOn.toggle()
    }

    func toggleFan() {
        alubox.fanOn.toggle()
    }

    func toggleDropdown() {
        withAnimation {
            isDropdownOpen.toggle()
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
