import SwiftUI

struct HourlyForecastView: View {
    let weatherResponse: WeatherResponse

    private var hourlyData: [HourlyWeather] {
        (weatherResponse.hourly ?? []).prefix(24).map { forecast in
            let time = formatUnixTime(forecast.dt, weatherResponse.timezoneOffset)
            let icon = mapWeatherIcon(forecast.weather.first?.icon ?? "01d")
            let description = forecast.weather.first?.description.capitalized ?? "N/A"
            let temp = "\(Int(forecast.temp))°"
            return HourlyWeather(time: time, icon: icon, description: description, temp: temp)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hourly Forecast")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(hourlyData.indices, id: \.self) { index in
                        HourlyWeatherCard(weather: hourlyData[index], isFirst: index == 0)
                    }
                }
            }
        }
    }
}

struct HourlyWeather {
    let time: String
    let icon: String
    let description: String
    let temp: String
}

struct HourlyWeatherCard: View {
    let weather: HourlyWeather
    let isFirst: Bool

    var body: some View {
        VStack(spacing: 6) {
            Text(weather.time)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)

            Image(systemName: weather.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 23, height: 23)
                .foregroundColor(.white)

            Text(weather.description)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)

            Text(weather.temp)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 75, height: 140)
        .background(isFirst ? .blue: Color(red: 56/255, green: 56/255, blue: 56/255))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
}
