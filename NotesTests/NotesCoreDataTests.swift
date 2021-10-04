//
//  NotesCoreDataTests.swift
//  NotesTests
//
//  Created by Dylan on 28/09/2021.
//

import XCTest
import CoreData
@testable import Notes

class NotesCoreDataTests: XCTestCase {
  
  var coreDataWrapper: NACoreDataFunctionWrapper!
  var coreDataTestStack: CoreDataTestStack!

    override func setUpWithError() throws {
      try super.setUpWithError()
      coreDataTestStack = CoreDataTestStack()
      coreDataWrapper = NACoreDataFunctionWrapper()
        
    }

    override func tearDownWithError() throws {
      try super.tearDownWithError()
    }
  
  func testCreateNote() {
    let note = Note(id: UUID(),
                        creationDateTime: Date(),
                        noteContent: "Test Content")
    coreDataWrapper.createNote(noteToSave: note)
    
    if let testNote = coreDataWrapper.getNoteByID(note: note) {
      XCTAssertEqual("Test Content", testNote.noteContent)
    }
  }
  
  func testUpdateNote() {
    let note = Note(id: UUID(),
                    creationDateTime: Date(),
                    noteContent: "Test Content")
    coreDataWrapper.createNote(noteToSave: note)
    
    coreDataWrapper.updateNote(noteToUpdate: note, updatedContent: "Updated Test Content")
    
    XCTAssertNil(coreDataWrapper.getNoteByID(note:note))
    XCTAssertEqual("Updated Test Content", note.noteContent)
    
  }
  
  func testDeleteNote() {
    let note1 = Note(id: UUID(),
                    creationDateTime: Date(),
                    noteContent: "Test Content")
    let note2 = Note(id: UUID(),
                    creationDateTime: Date(),
                    noteContent: "Test Content 2")
    coreDataWrapper.createNote(noteToSave: note1)
    coreDataWrapper.createNote(noteToSave: note2)
    
    coreDataWrapper.deleteNote(noteToDelete: note1)
    let notes = coreDataWrapper.getAllNotes()
    
    XCTAssertEqual(notes.count, 1)
    let remainingNote = notes.first
    XCTAssertEqual("Test Content 2", remainingNote?.noteContent)
  }
  
  func retrieveAllNotes() {
    
  }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
