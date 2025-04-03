import Foundation

class WeatherService {
    private let apiKey = APIKey.openWeatherAPIKey
    private let forecastBaseURL = "https://api.openweathermap.org/data/3.0/onecall"

    // Hardcoded coordinates for Copenhagen
    private let copenhagenLat = 55.6761
    private let copenhagenLon = 12.5683

    func fetchWeatherForCopenhagen() async throws -> WeatherResponse {
        let forecastURL = "\(forecastBaseURL)?lat=\(copenhagenLat)&lon=\(copenhagenLon)&units=metric&exclude=minutely,alerts&appid=\(apiKey)"
        var response = try await fetchWeatherData(from: forecastURL)

        if let cityInfo = try await reverseGeocode(lat: copenhagenLat, lon: copenhagenLon) {
            response.cityName = cityInfo.name
            response.country = cityInfo.country
        }

        return response
    }

    private func reverseGeocode(lat: Double, lon: Double) async throws -> CitySearchResult? {
        let urlString = "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=1&appid=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.requestFailed
        }

        let results = try JSONDecoder().decode([CitySearchResult].self, from: data)
        return results.first
    }

    private func fetchWeatherData(from urlString: String) async throws -> WeatherResponse {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.requestFailed
        }

        do {
            return try JSONDecoder().decode(WeatherResponse.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw APIError.decodingError
        }
    }
}

struct CitySearchResult: Codable, Identifiable {
    let id = UUID()
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?

    enum CodingKeys: String, CodingKey {
        case name, lat, lon, country, state
    }
}
