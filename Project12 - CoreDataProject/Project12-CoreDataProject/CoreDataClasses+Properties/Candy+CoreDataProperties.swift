//
//  Candy+CoreDataProperties.swift
//  Project12-CoreDataProject
//
//  Created by roberts.kursitis on 30/11/2022.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Some Candy"
    }

}

extension Candy : Identifiable {

}
