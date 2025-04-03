import SwiftUI
import MapKit

struct UIKitMapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.overrideUserInterfaceStyle = .dark
        mapView.delegate = context.coordinator

        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        mapView.setRegion(region, animated: false)

        // Add annotation
        let annotation = AluboxAnnotation(coordinate: coordinate)
        mapView.addAnnotation(annotation)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Not needed for now
    }

    // MARK: - Coordinator to customize annotation view
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is AluboxAnnotation else { return nil }

            let identifier = "AluboxMarker"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = false
            } else {
                annotationView?.annotation = annotation
            }

            // Create base image
            let boxImage = UIImage(named: "alubox1")?.resized(to: CGSize(width: 34, height: 34)) ?? UIImage()

            // Background container with rounded corners
            let backgroundSize: CGFloat = 50
            let container = UIView(frame: CGRect(x: 0, y: 0, width: backgroundSize, height: backgroundSize))
            container.backgroundColor = UIColor.black
            container.layer.cornerRadius = 10

            let imageView = UIImageView(image: boxImage)
            imageView.center = CGPoint(x: backgroundSize / 2, y: backgroundSize / 2)
            container.addSubview(imageView)

            // Render to UIImage
            UIGraphicsBeginImageContextWithOptions(container.bounds.size, false, 0)
            container.layer.render(in: UIGraphicsGetCurrentContext()!)
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            annotationView?.image = finalImage

            // Add pulsing shadow animation
            annotationView?.layer.shadowColor = UIColor.white.cgColor
            annotationView?.layer.shadowRadius = 8
            annotationView?.layer.shadowOpacity = 1
            annotationView?.layer.shadowOffset = .zero

            let pulse = CABasicAnimation(keyPath: "shadowRadius")
            pulse.fromValue = 8
            pulse.toValue = 16
            pulse.duration = 1.4
            pulse.autoreverses = true
            pulse.repeatCount = .infinity
            annotationView?.layer.add(pulse, forKey: "pulseShadow")

            return annotationView
        }
    }

}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

