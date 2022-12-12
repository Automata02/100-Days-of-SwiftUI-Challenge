//
//  ProspectsView.swift
//  Project16-HotProspects
//
//  Created by roberts.kursitis on 12/12/2022.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    enum SortingType {
        case date, name, random
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSorting = false
    @State private var sortingOrder = SortingType.date
    
    let filter: FilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        if filter == .none {
                            Text(prospect.isContacted ? prospect.name : "\(prospect.name) 🤙")
                                .font(.headline)
                        } else {
                            Text(prospect.name)
                                .font(.headline)
                        }
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.red)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingSorting = true
                    } label: {
                        Label("Sort", systemImage: "list.bullet")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hws.com", completion: handleScan)
            }
            .confirmationDialog("Select prefered sorting.", isPresented: $isShowingSorting) {
                Button("By Name") {
                    sortingOrder = .name
                }
                
                Button("Most Recent") {
                    sortingOrder = .date
                }
                //Returns a shuffled array, easeir to test if the other methods work
                Button("Surprise Me!") {
                    sortingOrder = .random
                }
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return " Contacted people"
        case . uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        let prospectArray: [Prospect]
        
        switch filter {
        case .none:
            prospectArray = prospects.people
        case .contacted:
            prospectArray = prospects.people.filter { $0.isContacted }
        case .uncontacted:
            prospectArray = prospects.people.filter { !$0.isContacted }
        }
        
        switch sortingOrder {
        case .name:
            return prospectArray.sorted { $0.name < $1.name }
        case .date:
            return prospectArray.sorted { $0.added > $1.added }
        case .random:
            return prospectArray.shuffled()
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            person.added = Date.now
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("oof.mp3")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
