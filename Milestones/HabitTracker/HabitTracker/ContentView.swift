//
//  ContentView.swift
//  HabitTracker
//
//  Created by roberts.kursitis on 24/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var didTap = false
    @State private var presentRules = false
    @State private var presentAdd = false
    @State private var presentDetails = false
    @State private var detailsTitle = ""
    @State private var detailsDesc = ""
    @State private var detailsMore = ""
    
    @State private var taskTextfield = ""
    @State private var taskDescTextfield = ""
    
    @State private var taskDict = [String: Int]() {
        didSet {
            UserDefaults.standard.set(taskDict, forKey: "primary")
            print("did set primary")
        }
    }
    @State private var taskInfo = [String: String]() {
        didSet {
            UserDefaults.standard.set(taskInfo, forKey: "secondary")
            print("did set secondary")
        }
    }
    typealias MutipleValue = (firstObject: Int, secondObject: String)
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Array(taskDict), id:\.key) { task, count in
                        HStack {
                            HStack {
                                Text("\(task), counter: \(String(count))")
                                Spacer()
                                Text("👆")
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                didTap.toggle()
                                let newCount = count + 1
                                taskDict.updateValue(newCount, forKey: task)
                                print(taskDict[task]!)
                            }
                            .onLongPressGesture {
                                detailsTitle = task
                                detailsMore = taskInfo[task] ?? "Somethings wrong, I can feel it"
                                if taskDict[task] == 1 {
                                    detailsDesc = "You've done this task once."
                                } else {
                                    detailsDesc = "You've done this task \(count) times."
                                }
                                presentDetails = true
                            }
                        }
                    }
                    .onTapGesture {
                        print("bingo")
                    }
                }
            }
            .navigationTitle("Habit Tracker✨")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button() {
                        presentRules.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        presentAdd.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Controls", isPresented: $presentRules) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Tap item to add to the total count, Hold on the item to see further details.")
            }
            
            .alert("Login", isPresented: $presentAdd) {
                TextField("New Task✨", text: $taskTextfield)
                TextField("Task Deets✨", text: $taskDescTextfield)
                Button("Add") {
                    taskTextfield != "" ? taskDict[taskTextfield] = 0 : print("textfield empty")
                    taskInfo[taskTextfield] = taskDescTextfield
                    taskTextfield = ""
                    taskDescTextfield = ""
                }
                Button("Cancel", role: .cancel, action: { })
            }
            
            .alert(detailsTitle, isPresented: $presentDetails) {
                Button("OK") {
                    detailsTitle = ""
                    detailsDesc = ""
                }
            } message: {
//                Text("\(detailsMore) \n \(detailsDesc)")
                Text(detailsMore != "" ? "\(detailsMore) \n \(detailsDesc)" : "\(detailsDesc)")
            }
        }
        .onAppear {
            if let savedDict = UserDefaults.standard.dictionary(forKey: "primary") {
                if let savedInfo = UserDefaults.standard.dictionary(forKey: "secondary") {
                    taskDict = savedDict as! [String : Int]
                    taskInfo = savedInfo as! [String : String]
                    print(savedDict)
                    print(savedInfo)
                }
            }
        }
    }
}

//MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
