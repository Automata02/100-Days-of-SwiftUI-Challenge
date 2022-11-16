//
//  ContentView.swift
//  Project06-Animations
//
//  Created by roberts.kursitis on 16/11/2022.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var isShowingRed = false
    
    @State private var animationAmount = 1.0
    @State private var anime = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var letters = Array("Hello World!")
    @State private var txtEnabled = false
    @State private var txtDragAmount = CGSize.zero
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.pink)
                    .frame(width: 200, height: 200)
                if isShowingRed {
                    Rectangle()
                        .fill(.black)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count) { num in
                    Text(String(letters[num]))
                        .padding(10)
                        .font(.headline)
                        .background(txtEnabled ? . blue : .red)
                        .offset(txtDragAmount)
                        .animation(.default.delay(Double(num) / 20), value: txtDragAmount)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { txtDragAmount = $0.translation }
                    .onEnded { _ in
                        txtDragAmount = .zero
                        txtEnabled.toggle()
                    }
            )
            
            LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 170, height: 170)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            withAnimation {
                                dragAmount = .zero
                                }
                            }
                )
            
            
            Button("B") {
                enabled.toggle()
            }
                .padding(20)
                .background(enabled ? .blue : .black)
                .foregroundColor(.white)
                .clipShape(enabled ? RoundedRectangle(cornerRadius: 25) : RoundedRectangle(cornerRadius: 5))
                .animation(.default, value: enabled)
            
            Button("G") {
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 15)) {
                    anime += 360
                }
            }
                .padding(20)
                .background(.green)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(anime), axis: (x: 0, y: 1, z: 0.5))
            
            Button("R") { }
                .padding(20)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.red)
                        .scaleEffect(animationAmount - 0.5)
                        .opacity(2 - animationAmount)
                        .animation(
                            .easeOut(duration: 1)
                            .repeatForever(autoreverses: false),
                            value: animationAmount)
                )
                .onAppear {
                    animationAmount = 2
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
