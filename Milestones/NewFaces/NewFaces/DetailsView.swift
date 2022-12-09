//
//  DetailsView.swift
//  NewFaces
//
//  Created by roberts.kursitis on 08/12/2022.
//

import SwiftUI
import MapKit

struct DetailsView: View {
    
    var image: Data?
    var name: String
    var company: String
    var location: CLLocation?
    
    @State private var showingMap = false
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var mapSpot: MKCoordinateRegion {
        let location = location?.coordinate ?? CLLocationCoordinate2D(latitude: 50, longitude: 0)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        return MKCoordinateRegion(center: location, span: span)
    }
    
    var place: [MapLocation] {
        return [MapLocation(name: "Here!", latitude: location?.coordinate.latitude ?? 0, longitude: location?.coordinate.longitude ?? 0)]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
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
                
                if showingMap {
                    Map(coordinateRegion: $mapRegion, annotationItems: place) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            VStack {
                                Image(systemName: "circle.dotted")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                Text(location.name)
                            }
                            .foregroundColor(.red)
                            .shadow(color: .blue, radius: 1, x: 2, y: 2)
                        }
                    }
                    .frame(width: 300, height: 300)
                    .cornerRadius(25)
                    .onAppear() {
                        mapRegion = mapSpot
                    }
                }
                Spacer()
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar() {
            ToolbarItem(placement: .navigationBarTrailing) {
                if location != nil {
                    Button() {
                        showingMap.toggle()
                    } label: {
                        Text(!showingMap ? "Show in Map" : "Hide Map")
                        Image(systemName: "location.fill")
                    }
                }
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
