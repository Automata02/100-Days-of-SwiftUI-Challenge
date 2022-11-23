//
//  SwiftUIView.swift
//  Project09-Drawing
//
//  Created by roberts.kursitis on 23/11/2022.
//

import SwiftUI

struct BlendView: View {
    @State private var amount = 0.0
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.red)
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                Circle()
                    .fill(.green)
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                Circle()
                    .fill(.blue)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount, in: 0...1)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.black)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BlendView()
    }
}
