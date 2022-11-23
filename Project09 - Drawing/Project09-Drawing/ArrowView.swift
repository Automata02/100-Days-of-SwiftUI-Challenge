//
//  ArrowView.swift
//  Project09-Drawing
//
//  Created by roberts.kursitis on 23/11/2022.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 30, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 30, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - 30, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - 30, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + 10, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
}

struct ArrowView: View {
    @State private var strokeAmount = 10.0
    
    var body: some View {
        VStack {
            Arrow()
                .stroke(.indigo, lineWidth: strokeAmount)
                .frame(width: 200, height: 200)
                .onTapGesture {
                    withAnimation {
                        strokeAmount += 10
                    }
                }
            Slider(value: $strokeAmount, in: 0...20)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.pink)
        .ignoresSafeArea()
    }
    
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
