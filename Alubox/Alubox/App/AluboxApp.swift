import SwiftUI

@main
struct AluboxApp: App {
    @StateObject private var weatherViewModel = WeatherViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(weatherViewModel) // 👈 inject it
        }
    }
}
