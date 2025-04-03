import Foundation

struct MockData {
    static let sampleBox = Alubox(
        name: "Garage Box",
        imageName: "alubox1", // Add this image to your assets
        isLocked: true,
        lightsOn: false,
        fanOn: false,
        sensorData: SensorData(
            temperature: 21.5,
            humidity: 40.0,
            isLidOpen: false,
            location: "Home Garage"
        ),
        boxInfo: BoxInfo(
            modelName: "Alubox Pro",
            version: "v2.1",
            purchaseDate: Date(timeIntervalSince1970: 1672531200), // Jan 1, 2023
            warrantyEnds: Date(timeIntervalSince1970: 1735689600)  // Jan 1, 2025
        )
    )
}
