import SwiftUI

struct CityInfoView: View {
    let weatherResponse: WeatherResponse

    var body: some View {
        VStack(spacing: 8) {
            // Summary
            Text(weatherResponse.daily?.first?.summary ?? "No summary available")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 10)
    }
}
