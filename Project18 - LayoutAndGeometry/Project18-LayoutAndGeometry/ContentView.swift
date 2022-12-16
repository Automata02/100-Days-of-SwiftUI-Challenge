//
//  ContentView.swift
//  Project18-LayoutAndGeometry
//
//  Created by roberts.kursitis on 15/12/2022.
//

import SwiftUI

struct ContentView: View {
    let sysCol = Color(uiColor: .systemBackground)

    var body: some View {
        ZStack {
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("Row #\(index)")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(uiColor: .label))
                                .frame(maxWidth: .infinity)
                                .background(
                                    withAnimation {
                                        Color(hue: min(1, geo.frame(in: .global).minY / fullView.size.height), saturation: 0.3, brightness: 1)
                                    }
                                )
                                .rotation3DEffect(.degrees(geo.frame(in: .global).midY - fullView.size.height / 2.17) / 5, axis: (x: 0, y: 1, z: 0))
                                .scaleEffect(max(0.5, geo.frame(in: .global).maxY / 800))
                                .opacity(geo.frame(in: .global).minY / 100)
                        }
                        .frame(height: 40)
                    }
                }
                .mask (
                    LinearGradient(colors: [.clear, sysCol, sysCol, .clear], startPoint: .bottom, endPoint: .top)
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
