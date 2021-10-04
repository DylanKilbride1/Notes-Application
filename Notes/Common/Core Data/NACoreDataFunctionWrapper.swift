//
//  NACoreDataFunctionWrapper.swift
//  Notes
//
//  Created by Dylan on 01/10/2021.
//

import Foundation
import UIKit
import CoreData

public class NACoreDataFunctionWrapper: NSObject {
  
  let context: NSManagedObjectContext
  
  init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
    self.context = mainContext
  }
  
  func getAllNotes() -> [NoteDataModel] {
    var notes = [NoteDataModel]()
    do {
      notes = try context.fetch(NoteDataModel.fetchRequest())
    } catch {
      //error
    }
    return notes
  }
  
  func getNoteByID(note: Note) -> NoteDataModel? {
    let id = note.id
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "NoteDataModel")
    let predicate = NSPredicate(format: "id = '\(id)'")
    fetchRequest.predicate = predicate
    do {
      let result = try context.fetch(fetchRequest)
      if let noteToRetrieve = result.first as? NoteDataModel {
        return noteToRetrieve
      }
    } catch let error {
      print("Failed to fetch: \(error)")
    }
    return nil
  }
  
  func createNote(noteToSave: Note) {
    let newNote = NoteDataModel(context: context)
    newNote.id = noteToSave.id
    newNote.noteContent = noteToSave.noteContent
    newNote.creationDateTime = Date()
    
    do {
      try context.save()
    } catch {
      print("error")
    }
  }
  
  func updateNote(noteToUpdate: Note, updatedContent: String) {

    let id = noteToUpdate.id
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "NoteDataModel")
    let predicate = NSPredicate(format: "id = '\(id)'")
    fetchRequest.predicate = predicate
    do {
      let result = try context.fetch(fetchRequest)
      if let objectToUpdate = result.first as? NSManagedObject {
        objectToUpdate.setValue(updatedContent, forKey: "noteContent")
        try context.save()
      }
    } catch {
      print(error)
    }
  }
  
  func deleteNote(noteToDelete: Note) {
    let id = noteToDelete.id
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "NoteDataModel")
    let predicate = NSPredicate(format: "id = '\(id)'")
    fetchRequest.predicate = predicate
    do {
      let result = try context.fetch(fetchRequest)
      if let objectToDelete = result.first as? NSManagedObject {
        context.delete(objectToDelete)
        try context.save()
      }
    } catch {
      print(error)
    }
    
    
//    let noteDataModel = transformNoteToNoteDataModel(noteToTransform: noteToDelete)
//    context.delete(noteDataModel)
//
//    do {
//      try context.save()
//    } catch {
//      print("Deletion error")
//    }
  }
  
  func transformNoteToNoteDataModel(noteToTransform: Note) -> NoteDataModel {
    let noteDataModel = NoteDataModel(context: context)
    noteDataModel.id = noteToTransform.id
    noteDataModel.noteContent = noteToTransform.noteContent
    noteDataModel.creationDateTime = noteToTransform.creationDateTime
    return noteDataModel
  }
  
}
