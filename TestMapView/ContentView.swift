//
//  ContentView.swift
//  TestMapView
//
//  Created by Richard Svoboda on 23.03.2024.
//


import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    
    var forDisplay = data
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.64422936785126, longitude: 142.39329541313924), span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 2))
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        /// showing annotation on the map
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else { return nil }
            
            if let landmarkAnnotation = annotation as? LandmarkAnnotation {
                return AnnotationView(annotation: landmarkAnnotation, reuseIdentifier: AnnotationView.ReuseID)
            } else if let cluster = annotation as? MKClusterAnnotation {
                var clusterView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomClusterView.reuseID)
                if clusterView == nil {
                    clusterView = CustomClusterView(annotation: cluster, reuseIdentifier: CustomClusterView.reuseID)
                    clusterView?.canShowCallout = false // This hides the callout
                } else {
                    clusterView?.annotation = cluster
                }
                clusterView?.canShowCallout = false // Hide callout for cluster annotations
                return clusterView
            }
            
            return nil
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("yo x")
        }
        
        func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
            print("yo y")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        MapView.Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        ///  creating a map
        let view = MKMapView()
        /// connecting delegate with the map
        view.delegate = context.coordinator
        view.setRegion(region, animated: false)
        view.mapType = .standard
        
        for points in forDisplay {
            let annotation = LandmarkAnnotation(coordinate: points.coordinate, color: points.color)
            view.addAnnotation(annotation)
        }
        
        return view
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}

struct SampleData: Identifiable {
    var id = UUID()
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
    let color: LandmarkColor
}

var data = [
    SampleData(latitude: 43.70564024126748, longitude: 142.37968945214223, color: .green),
    SampleData(latitude: 43.81257464206404, longitude: 142.82112322464369, color: .red),
    SampleData(latitude: 43.38416585162576, longitude: 141.7252598737476, color: .green),
    SampleData(latitude: 45.29168643283501, longitude: 141.95286751470724, color: .green),
    SampleData(latitude: 45.49261392585982, longitude: 141.9343973160499, color: .green),
    SampleData(latitude: 44.69825427301145, longitude: 141.91227845284203, color: .red)
]

enum LandmarkColor {
    case green, red
}

class LandmarkAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let color: LandmarkColor
    init(
        coordinate: CLLocationCoordinate2D,
        color: LandmarkColor
    ) {
        self.coordinate = coordinate
        self.color = color
        super.init()
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .ignoresSafeArea()
    }
}
