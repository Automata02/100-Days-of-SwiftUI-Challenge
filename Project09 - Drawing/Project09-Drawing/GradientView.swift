//
//  GradientView.swift
//  Project09-Drawing
//
//  Created by roberts.kursitis on 23/11/2022.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 1
    var start = UnitPoint(x: 0.5, y: 0)
    var end = UnitPoint(x: 0.5, y: 1)

    var body: some View {
        ZStack {
            ForEach(0..<steps, id:\.self) { value in
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [.pink, .indigo], startPoint: start, endPoint: end))
            }
        }
    }
}

struct GradientView: View {
    @State private var startX = 0.5
    @State private var startY = 0.0
    var startPoint: UnitPoint {
        return UnitPoint(x: startX, y: startY)
    }
    
    @State private var endX = 0.5
    @State private var endY = 1.0
    var endPoint: UnitPoint {
        return UnitPoint(x: endX, y: endY)
    }
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(start: startPoint, end: endPoint)
                .frame(width: 100, height: 100)
            Text("Start X: \(startX)")
            Slider(value: $startX, in: 0...1)
            Text("Start Y: \(startY)")
            Slider(value: $startY, in: 0...1)
            Text("End X: \(endX)")
            Slider(value: $endX, in: 0...1)
            Text("End Y: \(endY)")
            Slider(value: $endY, in: 0...1)
        }
        .padding()
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
            .preferredColorScheme(.dark)
    }
}
