//
//  TestCoreDataStack.swift
//  NotesTests
//
//  Created by Dylan on 04/10/2021.
//

import XCTest
import CoreData

class TestCoreDataStack: CoreData {

    override func setUpWithError() throws {
      super.setUp()
      CoreDataManager.shared(context: self.mockPersistantContainer.viewContext)
      
      initStubs()
      //Listen to the change in context
      NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave , object: nil)
    }

    override func tearDownWithError() throws {
      NotificationCenter.default.removeObserver(self)
      
      flushData()
      
      super.tearDown()
    }
    
  

}
