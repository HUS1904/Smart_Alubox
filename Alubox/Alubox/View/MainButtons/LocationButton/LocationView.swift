import SwiftUI
import MapKit

struct LocationView: View {
    @ObservedObject var viewModel: MainViewModel
    private let coordinate = CLLocationCoordinate2D(latitude: 55.6761, longitude: 12.5683)

    var body: some View {
        ZStack {
            // Fullscreen custom dark map
            UIKitMapView(coordinate: coordinate)
                .ignoresSafeArea()
                .zIndex(0)

            // "Navigate To" button
            VStack {
                Spacer()
                Button(action: openInMaps) {
                    Text("Navigate To")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 40)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 40)
            }
            .zIndex(1)
        }
    }

    func openInMaps() {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Alubox"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
