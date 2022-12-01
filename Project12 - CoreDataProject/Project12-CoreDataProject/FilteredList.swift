//
//  FilteredList.swift
//  Project12-CoreDataProject
//
//  Created by roberts.kursitis on 30/11/2022.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    enum Predicates {
        case beginsWith, endsWith
    }

    init(filterKey: String, filterValue: String, predicate: Predicates, sorters: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        let predicateString: String
        switch predicate {
        case .beginsWith:
            predicateString = "BEGINSWITH"
        case .endsWith :
            predicateString = "ENDSWITH"
        }

        _fetchRequest = FetchRequest<T>(sortDescriptors: sorters, predicate: NSPredicate(format: "%K \(predicateString) %@", filterKey, filterValue))
        self.content = content
    }
}

