//
//  DetailsView.swift
//  NewFaces
//
//  Created by roberts.kursitis on 08/12/2022.
//

import SwiftUI
import MapKit

struct DetailsView: View {
    
    let person = Person()
    
    var image: Data?
    var name: String
    var company: String
    var location: CLLocation?
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var mapSpot: MKCoordinateRegion {
        let location = location?.coordinate ?? CLLocationCoordinate2D(latitude: 50, longitude: 0)
        let span = MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        return MKCoordinateRegion(center: location, span: span)
    }
    
    var place: [MapLocation] {
        return [MapLocation(name: "Here!", latitude: location?.coordinate.latitude ?? 0, longitude: location?.coordinate.longitude ?? 0)]
    }
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(.horizontal)
            } else {
                Image("hank")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(0)
            }
            Text(name)
            Text(company)
            
            if location != nil {
                Map(coordinateRegion: $mapRegion, annotationItems: place) { location in
                    MapMarker(coordinate: location.coordinate)
                }
                .frame(width: 300, height: 300)
                .cornerRadius(25)
            }
        }
    }
}

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(name: "Hank Hill", company: "Strickland Propane")
    }
}
