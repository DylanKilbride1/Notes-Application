//
//  Note.swift
//  Notes
//
//  Created by Dylan on 01/10/2021.
//

import Foundation

struct NotesData: Decodable, Encodable {
  var count: Int
  var notes: [Note]
  
  enum CodingKeys: String, CodingKey {
    case count
    case notes
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    count = try container.decode(Int.self, forKey: .count)
    notes = try container.decode(Array.self, forKey: .notes)
  }
}



struct Note: Decodable, Encodable {
  var id: UUID
  var creationDateTime: Date
  var noteContent: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case creationDateTime = "creation_date_time"
    case noteContent = "content"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = UUID(uuidString: try container.decode(String.self, forKey: .id))!
    creationDateTime = try container.decode(Date.self, forKey: .creationDateTime)
    noteContent = try container.decode(String.self, forKey: .noteContent)
  }
  
  init(id: UUID, creationDateTime: Date, noteContent: String) {
    self.id = id
    self.creationDateTime = creationDateTime
    self.noteContent = noteContent
  }
}
