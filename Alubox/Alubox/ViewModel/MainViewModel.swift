import SwiftUI
import Foundation

enum ActiveSection {
    case none
    case controls
    case climate
    case location
    case inventory
    case specifications
}

class MainViewModel: ObservableObject {
    @Published var activeSection: ActiveSection = .none
    @Published var isDropdownOpen: Bool = false

    @Published var alubox: Alubox = MockData.sampleBox

    func resetView() {
        activeSection = .none
    }

    func toggleLock() {
        alubox.isLocked.toggle()
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
