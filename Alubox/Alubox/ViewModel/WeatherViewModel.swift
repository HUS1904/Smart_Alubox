import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse?

    private let weatherService = WeatherService()

    func fetchWeatherForCopenhagen() {
        Task {
            do {
                let weather = try await weatherService.fetchWeatherForCopenhagen()
                self.weatherResponse = weather
            } catch {
                print("Failed to fetch Copenhagen weather: \(error)")
            }
        }
    }
}
