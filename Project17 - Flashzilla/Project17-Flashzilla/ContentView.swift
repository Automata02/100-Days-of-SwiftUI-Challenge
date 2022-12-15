//
//  ContentView.swift
//  Project17-Flashzilla
//
//  Created by roberts.kursitis on 13/12/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEbabled
    @State private var cards = [Card]()
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                ZStack {
                    ForEach(Array(cards.enumerated()), id: \.element) { item in
                        CardView(card: item.element) { vibeCheck in
                            withAnimation {
                                removeCard(at: item.offset, toBack: vibeCheck)
                            }
                        }
                        .stacked(at: item.offset, in: cards.count)
                        .allowsHitTesting(item.offset == cards.count - 1)
                        .accessibilityHidden(item.offset < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                Spacer()
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.75))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            #warning("commented out due to changes done to the removeCard function")
//            if differentiateWithoutColor || voiceOverEbabled {
//                VStack {
//                    Spacer()
//
//                    HStack {
//                        Button {
//                            withAnimation {
//                                removeCard(at: cards.count - 1)
//                            }
//                        } label: {
//                            Image(systemName: "xmark.circle")
//                                .padding()
//                                .background(.black.opacity(0.75))
//                                .clipShape(Circle())
//                        }
//                        .accessibilityLabel("Wrong")
//                        .accessibilityHint("Mark your answer as being incorrect")
//
//                        Spacer()
//
//                        Button {
//                            withAnimation {
//                                removeCard(at: cards.count - 1)
//                            }
//                        } label: {
//                            Image(systemName: "checkmark.circle")
//                                .padding()
//                                .background(.black.opacity(0.75))
//                                .clipShape(Circle())
//                        }
//                        .accessibilityLabel("Correct")
//                        .accessibilityHint("Mark your answer as being correct")
//                    }
//                    .foregroundColor(.white)
//                    .font(.largeTitle)
//                    .padding()
//                }
//            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int, toBack: Bool) {
        guard index >= 0 else { return }
        
        if toBack {
            cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
        } else {
            cards.remove(at: index)
        }
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        cards = loadDataFromDocs()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
