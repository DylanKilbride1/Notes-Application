//
//  APIService.swift
//  Notes
//
//  Created by Dylan on 30/09/2021.
//

import UIKit

protocol APIService {

  func fetchNotes(completion: @escaping (Bool, NotesData?) -> Void)
  func createNote(noteToCreate: Note, completion: @escaping (Bool) -> Void)
  func editNote(editedNote: Note, completion: @escaping (Bool) -> Void)
  func deleteNote(noteToDelete: Note, completion: @escaping (Bool) -> Void)
    
}

final class ApiClient: APIService {
  
  func fetchNotes(completion: @escaping (Bool, NotesData?) -> Void) {
    //Code to make GET request for remote API would go here
  }
  
  func createNote(noteToCreate: Note, completion: @escaping (Bool) -> Void) {
    //Code to make POST request for remote API would go here
  }
  
  func editNote(editedNote: Note, completion: @escaping (Bool) -> Void) {
    //Code to make PUT request for remote API would go here
  }
  
  func deleteNote(noteToDelete: Note, completion: @escaping (Bool) -> Void) {
    //Code to make DELETE request for remote API would go here
  }
  
}

final class MockApiClient: APIService {
  
  enum MockHTTPOperation {
    case create
    case delete
    case edit
  }
  
  private static let timeDelay = 0 //Can replicate a slow internet connection
  private static let filePath = "notes"
  private var notesData = NotesData(count: 0, notes: [Note]())
  
  func fetchNotes(completion: @escaping (Bool, NotesData?) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockApiClient.timeDelay)) {
      MockApiClient.loadJsonDataFromFile(MockApiClient.filePath, completion: { data in
        if let json = data {
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            let notesData = try jsonDecoder.decode(NotesData.self, from: json)
            completion(true, notesData)
          }
          catch _ as NSError {
            print("Couldn't load data from \(MockApiClient.filePath)")
            completion(false, nil)
          }
        }
      })
    }
  }
  
  func createNote(noteToCreate: Note, completion: @escaping (Bool) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockApiClient.timeDelay)) {
      let success = self.writeToFile(path: MockApiClient.filePath,
                                     objectToWrite: noteToCreate,
                                     operation: .create)
      success ? completion(true) : completion(false)
    }
  }
  
  func editNote(editedNote: Note, completion: @escaping (Bool) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockApiClient.timeDelay)) {
      let success = self.writeToFile(path: MockApiClient.filePath,
                                     objectToWrite: editedNote,
                                     operation: .edit)
      success ? completion(true) : completion(false)
    }
  }
  
  func deleteNote(noteToDelete: Note, completion: @escaping (Bool) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockApiClient.timeDelay)) {
      let success = self.writeToFile(path: MockApiClient.filePath,
                                     objectToWrite: noteToDelete,
                                     operation: .delete)
      success ? completion(true) : completion(false)
    }
  }
  
  //Helpers
  private static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
    if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
      do {
        let data = try Data(contentsOf: fileUrl, options: [])
        completion(data as Data)
      } catch (let error) {
        print(error.localizedDescription)
        completion(nil)
      }
    }
  }
  
  private func writeToFile(path: String,
                           objectToWrite: Note,
                           operation: MockHTTPOperation) -> Bool {
    
    switch operation {
      case .create:
        notesData.notes.append(objectToWrite)
      case .delete:
        if let index = notesData.notes.firstIndex(where: {$0.id == objectToWrite.id}) {
          notesData.notes.remove(at: index)
        }
      case .edit:
        if let index = notesData.notes.firstIndex(where: {$0.id == objectToWrite.id}) {
          notesData.notes[index].noteContent = objectToWrite.noteContent
        }
    }
    
    if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
      do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let JsonData = try encoder.encode(notesData)
        try JsonData.write(to: fileUrl)
        return true
      } catch {
        print("write error")
      }
    }
    return false
  }
}
