//
//  NACoreDataFunctionWrapper.swift
//  Notes
//
//  Created by Dylan on 01/10/2021.
//

import Foundation
import UIKit

public class NACoreDataFunctionWrapper: NSObject {
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  func getAllNotes() -> [NoteDataModel] {
    var notes = [NoteDataModel]()
    do {
      notes = try context.fetch(NoteDataModel.fetchRequest())
    } catch {
      //error
    }
    return notes
  }
  
  func getNoteByID() {
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
  
  func updateNote(noteToUpdate: NoteDataModel, updatedContent: String) {
    noteToUpdate.noteContent = updatedContent
    
    do {
      try context.save()
    } catch {
      //errors
    }
  }
  
  func deleteNote(noteToDelete: NoteDataModel) {
    context.delete(noteToDelete)
    
    do {
      try context.save()
    } catch {
      //errors
    }
  }
  
}
