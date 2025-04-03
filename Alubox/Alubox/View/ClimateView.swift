import SwiftUI

struct ClimateView: View {
    @State private var isClimateOn: Bool = false
    @State private var targetTemperature: Int = 21

    var body: some View {
        VStack(spacing: 20) {
            Text("Box Climate")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)

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
                        .foregroundColor(isClimateOn ? .white : .gray)
                }

                // Target Temp Control
                HStack(spacing: 12) {
                    Button {
                        targetTemperature -= 1
                    } label: {
                        Text("<")
                            .font(.title)
                            .foregroundColor(.white)
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
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}
