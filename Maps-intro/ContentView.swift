import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.3323341, longitude: -122.0312186),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )

    @State private var places = [
        Place(name: "nice place", latitude: 37.332, longitude: -122.032),
        Place(name: "good place", latitude: 37.332, longitude: -122.03),
        Place(name: "different place", latitude: 37.332, longitude: -122.029)
    ]

    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                interactionModes: [.all],
                annotationItems: places) { place in
                MapAnnotation(coordinate: place.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    MapPinView(place: place) 
                }
            }
            .frame(height: 400)

            Button("Start updates") {
                locationManager.startLocationUpdates()
            }
            .padding()

            Button("Add pin") {
                addPin()
            }
        }
        .onReceive(locationManager.$location) { location in
            guard let location = location else { return }
            region.center = location
        }
    }

    func addPin() {
        if let location = locationManager.location {
            let newPlace = Place(name: "Here", latitude: location.latitude, longitude: location.longitude)
            places.append(newPlace)
        }
    }
}

struct MapPinView: View {
    var place: Place

    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .resizable()
                .frame(width: 30, height: 30)
            Text(place.name)
                .font(.caption)
                .foregroundColor(.black)
        }
    }
}
