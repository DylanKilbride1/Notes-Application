//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Dylan on 30/09/2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var noteContent: String?
    @NSManaged public var creationDateTime: Date?

}
