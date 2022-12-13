//
//  CardView.swift
//  Project17-Flashzilla
//
//  Created by roberts.kursitis on 13/12/2022.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.yellow)
                .shadow(radius: 10)
            VStack {
                Text(card.promt)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture (
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width > 100 {
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
        
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
