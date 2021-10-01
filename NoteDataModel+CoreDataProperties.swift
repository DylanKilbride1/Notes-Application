//
//  NoteDataModel+CoreDataProperties.swift
//  
//
//  Created by Dylan on 01/10/2021.
//
//

import Foundation
import CoreData

extension NoteDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteDataModel> {
        return NSFetchRequest<NoteDataModel>(entityName: "NoteDataModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var creationDateTime: Date?
    @NSManaged public var noteContent: String?

}
