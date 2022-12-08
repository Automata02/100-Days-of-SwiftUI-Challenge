//
//  ContentView.swift
//  NewFaces
//
//  Created by roberts.kursitis on 08/12/2022.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var people: FetchedResults<Person>
    
    @State private var showingAddPerson = false
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    @State private var selectedPicture: Image?
    
    @State private var textFieldName = ""
    @State private var textFieldCompany = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    PhotosPicker(selection: $selectedItem, matching: .any(of: [.images, .not(.livePhotos), .not(.screenshots)])) {
                        Label("Add a new person", systemImage: "plus")
                            .foregroundColor(.blue)
                    }
                    
                    ForEach(people) { person in
                        NavigationLink(destination: DetailsView(image: person.picture!, name: person.name ?? "Unknown", company: person.company ?? "Unknown")) {
                            HStack {
                                Image(uiImage: UIImage(data: person.picture!)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                                    .padding(.horizontal)
                                VStack(alignment: .leading) {
                                    Text(person.name ?? "Unknown")
                                    Text(person.company ?? "Unknown")
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeEntry)
                }
            }
            .onChange(of: selectedItem) { newPhoto in
                Task {
                    if let data = try? await newPhoto?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                        guard let newPicture = UIImage(data: data) else { return }
                        selectedPicture = Image(uiImage: newPicture)
                        showingAddPerson = true
                    }
                }
            }
            .sheet(isPresented: $showingAddPerson) {
                NavigationView {
                    VStack {
                        Form {
                            HStack {
                                if let selectedPicture {
                                    selectedPicture
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .padding()
                                } else {
                                    Image("hank")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .padding(0)
                                }
                                VStack {
                                    TextField("Enter name", text: $textFieldName)
                                        .padding(.bottom)
                                    TextField("Enter Company", text: $textFieldCompany)
                                }
                            }
                        }
                    }
                    .navigationTitle(textFieldName == "" ? "New Person" : "\(textFieldName)")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel", role: .cancel) {
                                showingAddPerson = false
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Save") {
                                let newPerson = Person(context: moc)
                                newPerson.name = textFieldName
                                newPerson.company = textFieldCompany
                                newPerson.picture = selectedPhotoData
                                try? moc.save()
                                
                                textFieldName = ""
                                textFieldCompany = ""
                                
                                showingAddPerson = false
                            }
                        }
                    }
                }
            }
            .navigationTitle("New Faces")
        }
    }
    
    func removeEntry(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            moc.delete(person)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
