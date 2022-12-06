//
//  ContentView.swift
//  Project14-BucketList
//
//  Created by roberts.kursitis on 06/12/2022.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            #warning("Switch this to have FaceID.")
            if viewModel.isUnlocked {
                ZStack {
                    Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            VStack {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(Circle())
                                Text(location.name)
                            }
                            .onTapGesture {
                                viewModel.selectedPlace = location
                            }
                        }
                    }
                    .ignoresSafeArea()
                    
                    Circle()
                        .fill(.red.opacity(0.5))
                        .frame(width: 32)
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Button {
                                viewModel.addLocation()
                            } label: {
                                Image(systemName: "plus")
                            }
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                        }
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) { newLocation in
                        viewModel.update(location: newLocation)
                    }
                }
            } else {
                Button() {
                    viewModel.authenticate()
                } label: {
                    Label("Tap to Unlock", systemImage: "lock.fill")
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
