//
//  NoteModel.swift
//  Notes
//
//  Created by Dylan on 29/09/2021.
//

import Foundation

struct Note: Identifiable {
  let id: Int
  let creationDateTime: String
  let noteContent: String
}

extension Note : Decodable {
  enum CodingKeys: String, CodingKey {
    case id
    case creationDateTime = "creation_date_time"
    case noteContent = "content"
  }
}
