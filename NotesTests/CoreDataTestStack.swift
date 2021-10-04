//
//  CoreDataTestStack.swift
//  Notes
//
//  Created by Dylan on 04/10/2021.
//

import Foundation
import CoreData

class CoreDataTestStack {
  
  static let shared = CoreDataTestStack()
  
  let persistentContainer: NSPersistentContainer
  let backgroundContext: NSManagedObjectContext
  let mainContext: NSManagedObjectContext
  
  public init() {
    persistentContainer = NSPersistentContainer(name: "NoteDataModel")
    let description = persistentContainer.persistentStoreDescriptions.first
    description?.type = NSInMemoryStoreType
    
    persistentContainer.loadPersistentStores { description, error in
      guard error == nil else {
        fatalError("Unable to load persistent storage")
      }
    }
    
    mainContext = persistentContainer.viewContext
    
    backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    backgroundContext.parent = self.mainContext
  }
}
