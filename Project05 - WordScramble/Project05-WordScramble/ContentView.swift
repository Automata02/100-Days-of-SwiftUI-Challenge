//
//  ContentView.swift
//  Project05-WordScramble
//
//  Created by roberts.kursitis on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        Section {
                            TextField("Enter your word", text: $newWord)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                        }
                        Section("Used words") {
                            ForEach(usedWords, id: \.self) { word in
                                HStack {
                                    Image(systemName: "\(word.count).circle.fill")
                                    Text(word)
                                }
                                .accessibilityElement()
                                .accessibilityLabel(word)
                                .accessibilityHint("\(word.count) letters")
                            }
                        }
                    }
                    .navigationTitle(rootWord.isEmpty ? "WordScramble" : rootWord.capitalized)
                    .toolbar {
                        Button("\(Image(systemName: "arrow.clockwise"))", action: startGame)
                    }
                    .listStyle(.insetGrouped)
                    .onSubmit(addNewWord)
                    .onAppear(perform: startGame)
                    .alert(errorTitle, isPresented: $showingError) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text(errorMsg)
                    }
                }
                ZStack() {
                    Text("Score: \(score)")
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 2 else {
            wordError(title: "Word too short.", msg: "Sorry, words must be at least three letters long.")
            return
        }
        
        guard isOriginal(answer) else {
            wordError(title: "Word used already.", msg: "Be more original!")
            newWord = ""
            return
        }
        guard isPossible(answer) else {
            wordError(title: "Word not possible.", msg: "You can't spell that word from \(rootWord).")
            newWord = ""
            return
        }
        guard isReal(answer) else {
            wordError(title: "Word not recognized.", msg: "You can't just make them up!")
            newWord = ""
            return
        }
        score += 1
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        usedWords.removeAll()
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "milkform"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, msg: String) {
        errorTitle = title
        errorMsg = msg
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
