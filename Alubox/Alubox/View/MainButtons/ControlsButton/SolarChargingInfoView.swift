import SwiftUI
import Charts

// MARK: - Model

struct EnergyPoint: Identifiable {
    let id = UUID()
    let day: String
    let kWh: Double
    let type: String // "Charged" or "Spent"
}

// MARK: - Sample Data

let weeklyEnergyPoints: [EnergyPoint] = [
    EnergyPoint(day: "Mon", kWh: 2.4, type: "Charged"),
    EnergyPoint(day: "Tue", kWh: 3.1, type: "Charged"),
    EnergyPoint(day: "Wed", kWh: 2.9, type: "Charged"),
    EnergyPoint(day: "Thu", kWh: 3.4, type: "Charged"),
    EnergyPoint(day: "Fri", kWh: 3.6, type: "Charged"),
    EnergyPoint(day: "Sat", kWh: 4.0, type: "Charged"),
    EnergyPoint(day: "Sun", kWh: 3.2, type: "Charged"),

    EnergyPoint(day: "Mon", kWh: 1.8, type: "Spent"),
    EnergyPoint(day: "Tue", kWh: 2.5, type: "Spent"),
    EnergyPoint(day: "Wed", kWh: 2.0, type: "Spent"),
    EnergyPoint(day: "Thu", kWh: 2.7, type: "Spent"),
    EnergyPoint(day: "Fri", kWh: 3.0, type: "Spent"),
    EnergyPoint(day: "Sat", kWh: 3.2, type: "Spent"),
    EnergyPoint(day: "Sun", kWh: 3.3, type: "Spent"),
]

// MARK: - Chart View

struct EnergyLineChartView: View {
    let backgroundColor = Color(red: 0.156, green: 0.156, blue: 0.156)

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Charging Statistics")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Subtitle
            Text("Last 7 days")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, -8)

            // Totals row
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Total Charged")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                    Text("12.4 kWh")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("Total Used")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                    Text("9.8 kWh")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }

            // Chart (unchanged)
            ZStack(alignment: .topLeading) {
                Chart(weeklyEnergyPoints) { point in
                    LineMark(
                        x: .value("Day", point.day),
                        y: .value("kWh", point.kWh)
                    )
                    .interpolationMethod(.linear)
                    .symbol(by: .value("Type", point.type))
                    .foregroundStyle(by: .value("Type", point.type))
                }
                .frame(height: 160)
                .chartForegroundStyleScale([
                    "Charged": Color.blue,
                    "Spent": Color.red
                ])
                .chartLegend(position: .top, alignment: .center)
                .chartLegend {
                    HStack(spacing: 24) {
                        HStack(spacing: 6) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 10, height: 10)
                            Text("Charged")
                                .foregroundColor(.white)
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        HStack(spacing: 6) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                            Text("Spent")
                                .foregroundColor(.white)
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisGridLine()
                            .foregroundStyle(Color.white.opacity(0.2))
                        AxisTick()
                            .foregroundStyle(.white)
                        AxisValueLabel {
                            if let val = value.as(Double.self) {
                                Text(String(format: "%.0f", val))
                                    .foregroundColor(.white)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks(values: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]) { value in
                        AxisTick()
                            .foregroundStyle(.white)
                        AxisGridLine()
                            .foregroundStyle(Color.clear)
                        AxisValueLabel {
                            if let day = value.as(String.self) {
                                Text(day)
                                    .foregroundColor(.white)
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                .padding()
                .background(backgroundColor)

                Text("kWh")
                    .foregroundColor(.white)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.top, 4)
                    .padding(.leading, 16)
            }
        }
        .padding()
        .background(backgroundColor)
    }
}

// MARK: - Main View

struct SolarChargingInfoView: View {
    var body: some View {
        EnergyLineChartView()
    }
}
