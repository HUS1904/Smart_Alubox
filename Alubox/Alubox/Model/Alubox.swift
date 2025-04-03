import Foundation

struct Alubox: Identifiable {
    let id = UUID()
    var name: String
    var imageName: String
    var isLocked: Bool
    var lightsOn: Bool
    var fanOn: Bool
    var sensorData: SensorData
    var boxInfo: BoxInfo
}
