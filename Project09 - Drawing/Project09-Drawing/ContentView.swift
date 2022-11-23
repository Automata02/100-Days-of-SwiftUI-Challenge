//
//  ContentView.swift
//  Project09-Drawing
//
//  Created by roberts.kursitis on 23/11/2022.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: Double
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct ContentView: View {
    @State private var isShowingPetal = false
    @State private var isShowingBlend = false
    @State private var isShowingArrow = false
    @State private var isShowingGradient = false
    @State private var insetAmount = 50.0
    
    var body: some View {
        NavigationView {
            VStack {
                Trapezoid(insetAmount: insetAmount)
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        withAnimation {
                            insetAmount = Double.random(in: 10...90)
                        }
                    }
            }
            .toolbar {
                Button() {
                    isShowingPetal.toggle()
                } label: {
                    Text("Petal")
                }
                Button() {
                    isShowingBlend.toggle()
                } label: {
                    Text("Blend")
                }
                Button() {
                    isShowingArrow.toggle()
                } label: {
                    Text("Arrow")
                }
                Button() {
                    isShowingGradient.toggle()
                } label: {
                    Text("Gradient")
                }
            }
        }
        .sheet(isPresented: $isShowingPetal) {
            PetalView()
        }
        .sheet(isPresented: $isShowingBlend) {
            BlendView()
        }
        .sheet(isPresented: $isShowingArrow) {
            ArrowView()
        }
        .sheet(isPresented: $isShowingGradient) {
            GradientView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
