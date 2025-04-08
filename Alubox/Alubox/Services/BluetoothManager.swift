import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject {
    static let shared = BluetoothManager() // Singleton

    private var centralManager: CBCentralManager!
    private var aluboxPeripheral: CBPeripheral?
    private var lockCharacteristic: CBCharacteristic?

    let serviceUUID = CBUUID(string: "00001234-0000-1000-8000-00805F9B34FB")
    let characteristicUUID = CBUUID(string: "00005678-0000-1000-8000-00805F9B34FB")

    @Published var isReady = false

    private override init() {
        super.init()
        print("🧠 BluetoothManager init triggered")
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func writeLockCommand(_ command: String) {
        guard let peripheral = aluboxPeripheral,
              let characteristic = lockCharacteristic else {
            print("❌ Cannot write command '\(command)': Missing peripheral or characteristic.")
            return
        }

        let data = command.data(using: .utf8)!
        print("✍️ Writing command: \(command)")
        peripheral.writeValue(data, for: characteristic, type: .withResponse)
    }

    func ensureScanning() {
        if centralManager.state == .poweredOn && aluboxPeripheral == nil {
            print("🔄 Retrying BLE scan from ensureScanning()")
            centralManager.scanForPeripherals(withServices: [serviceUUID])
        }
    }
}

extension BluetoothManager: CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("🔍 Scanning for Alubox Lock...")
            centralManager.scanForPeripherals(withServices: [serviceUUID])
        } else {
            print("❌ Bluetooth not available: \(central.state.rawValue)")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print("📡 Discovered device: \(peripheral.name ?? "Unnamed")")
        if peripheral.name == "Alubox Lock" {
            print("✅ Found Alubox Lock! Connecting...")
            aluboxPeripheral = peripheral
            centralManager.stopScan()
            peripheral.delegate = self
            centralManager.connect(peripheral)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("🔗 Connected to ESP32")
        peripheral.discoverServices([serviceUUID])
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }

        for service in services {
            print("🧩 Discovered service: \(service.uuid)")
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }

        for characteristic in characteristics {
            print("✅ Found characteristic: \(characteristic.uuid)")
            if characteristic.uuid == characteristicUUID {
                lockCharacteristic = characteristic
                isReady = true
                print("✅ Bluetooth ready for commands")
            }
        }
    }
}
