//
//  HelperFunctions.swift
//  Alubox
//
//  Created by Hussein Jarrah on 03/04/2025.
//

import Foundation

func formatUnixTime(_ timestamp: Int, _ offset: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp + offset))
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
}

func formatDay(_ timestamp: Int, _ offset: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp + offset))
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE"
    return formatter.string(from: date)
}


func mapWeatherIcon(_ iconCode: String) -> String {
    switch iconCode {
    case "01d": return "sun.max.fill"
    case "01n": return "moon.fill"
    case "02d", "02n": return "cloud.sun.fill"
    case "03d", "03n": return "cloud.fill"
    case "04d", "04n": return "smoke.fill"
    case "09d", "09n": return "cloud.drizzle.fill"
    case "10d", "10n": return "cloud.rain.fill"
    case "11d", "11n": return "cloud.bolt.rain.fill"
    case "13d", "13n": return "snow"
    case "50d", "50n": return "cloud.fog.fill"
    default: return "questionmark.circle"
    }
}
