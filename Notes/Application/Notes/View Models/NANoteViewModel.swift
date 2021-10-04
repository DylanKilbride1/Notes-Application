//
//  NANoteViewModel.swift
//  Notes
//
//  Created by Dylan on 30/09/2021.
//

import Foundation
import UIKit

class NANoteViewModel: NSObject {
  
  let coreDataWrapper = NACoreDataFunctionWrapper()
  
  //Date Formatting
  public func formatDate(date: Date) -> String {
    let longFormat = DateFormatter()
    longFormat.dateFormat = DateFormats.longDateTimeFormat
    return longFormat.string(from: date)
  }
  
  //Local Data Methods
  public func createNewNote(noteData: Note) {
    coreDataWrapper.createNote(noteToSave: noteData)
  }
  
  public func updateExistingNote(noteToUpdate: Note, updatedContent: String) {
    coreDataWrapper.updateNote(noteToUpdate: noteToUpdate,
                               updatedContent: updatedContent ?? "")
  }
  
  public func deleteExistingNote(noteToDelete: Note) {
    coreDataWrapper.deleteNote(noteToDelete: noteToDelete)
  }
  
  public func retrieveAllNotes() -> [Note] {
    return transformCoreDataModelsToNoteModels(noteDataModels: coreDataWrapper.getAllNotes())
  }
  
  //Not needed
//  public func retrieveNoteByUUID() {
//
//  }
  
  private func transformCoreDataModelsToNoteModels(noteDataModels: [NoteDataModel]) -> [Note] {
    var noteModels = [Note]()
    for noteDataModel in noteDataModels {
      noteModels.append(Note(id: noteDataModel.id!,
                             creationDateTime: noteDataModel.creationDateTime!,
                             noteContent: noteDataModel.noteContent!))
    }
    return noteModels
  }

}
