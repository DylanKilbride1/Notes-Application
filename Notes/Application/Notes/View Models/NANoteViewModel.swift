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
  let apiService = MockApiClient()
  private var apiNotesData: NotesData? {
    didSet {
    }
  }
  
  //Date Formatting
  public func formatDate(date: Date) -> String {
    let longFormat = DateFormatter()
    longFormat.dateFormat = DateFormats.longDateTimeFormat
    return longFormat.string(from: date)
  }
  
  public func createNewNote(noteData: Note) {
   coreDataWrapper.createNote(noteToSave: noteData)
    apiService.createNote(noteToCreate: noteData, completion: { (success) in
      //Callback to update user
    })
  }
  
  public func updateExistingNote(noteToUpdate: Note, updatedContent: String) {
    var note = noteToUpdate
    note.noteContent = updatedContent
    coreDataWrapper.updateNote(noteToUpdate: noteToUpdate,
                               updatedContent: updatedContent)
    apiService.editNote(editedNote: note, completion: { (success) in
      //Callback to update user
    })
  }
  
  public func deleteExistingNote(noteToDelete: Note) {
    coreDataWrapper.deleteNote(noteToDelete: noteToDelete)
    apiService.deleteNote(noteToDelete: noteToDelete, completion: { (success) in
      //Callback to update user
    })
  }
  
  public func retrieveAllNotes(remoteRetreiveCompletion: @escaping ([Note]) -> Void) -> [Note] {
    let localNotes = transformCoreDataModelsToNoteModels(noteDataModels: coreDataWrapper.getAllNotes())
    apiService.fetchNotes(completion: { (success, notes) in
      self.apiNotesData = notes
      if let remoteNotes = self.apiNotesData {
        
        remoteRetreiveCompletion(self.mergeAndSortRemoteWithLocalNotes(localNotes: localNotes,
                                                                  remoteNotes: remoteNotes.notes))
      }
    })
    return localNotes
  }
  
  
  //Helper
  private func transformCoreDataModelsToNoteModels(noteDataModels: [NoteDataModel]) -> [Note] {
    var noteModels = [Note]()
    for noteDataModel in noteDataModels {
      noteModels.append(Note(id: noteDataModel.id!,
                             creationDateTime: noteDataModel.creationDateTime!,
                             noteContent: noteDataModel.noteContent!))
    }
    return noteModels
  }
  
  private func mergeAndSortRemoteWithLocalNotes(localNotes: [Note], remoteNotes: [Note]) -> [Note] {
    let allNotes = [localNotes, remoteNotes].flatMap { $0 }
    let uniqueNotes = allNotes.removingDuplicates(byKey: { $0.id })
    return uniqueNotes.sorted(by: { $0.creationDateTime.compare($1.creationDateTime) == .orderedDescending })
  }
}

extension Array {
  func removingDuplicates<T: Hashable>(byKey key: (Element) -> T)  -> [Element] {
    var result = [Element]()
    var seen = Set<T>()
    for value in self {
      if seen.insert(key(value)).inserted {
        result.append(value)
      }
    }
    return result
  }
}
