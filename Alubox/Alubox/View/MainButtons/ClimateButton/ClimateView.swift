import SwiftUI

struct ClimateView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @State private var isClimateOn: Bool = false
    @State private var targetTemperature: Int = 21

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    // Current Temp
                    VStack {
                        Text("Temp")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                        Text("21°C")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    // Humidity
                    VStack {
                        Text("Humidity")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                        Text("45%")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    // On/Off Toggle
                    Button(action: {
                        isClimateOn.toggle()
                    }) {
                        Image(systemName: "power.circle.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.white, isClimateOn ? .blue : .gray)
                    }

                    // Target Temp Control
                    HStack(spacing: 12) {
                        Button {
                            targetTemperature -= 1
                        } label: {
                            Text("<")
                                .font(.title)
                                .foregroundColor(.blue)
                        }

                        Text("\(targetTemperature)°C")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)

                        Button {
                            targetTemperature += 1
                        } label: {
                            Text(">")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                    }
                }.padding(.top,-10)
 

                // WEATHER SECTION
                if let weather = weatherViewModel.weatherResponse {
                    VStack(spacing: 16) {
                        CityInfoView(weatherResponse: weather)
                        HourlyForecastView(weatherResponse: weather)
                        WeeklyForecastView(weatherResponse: weather)

                        HStack(spacing: 12) {
                            RainWidget(weatherResponse: weather)
                            FeelsLikeWidget(weatherResponse: weather)
                        }

                        HStack(spacing: 12) {
                            AirHumidityWidgetView(weatherResponse: weather)
                            UvIndexWidgetView(weatherResponse: weather)
                        }
                        
                        WindWidgetView(weatherResponse: weather)
                            .padding(.bottom, 50)
                    }
                    .padding(.top, 30)
                } else {
                    ProgressView("Loading weather...")
                        .padding(.top, 20)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .onAppear {
                weatherViewModel.fetchWeatherForCopenhagen()
            }

        }
    }
}
