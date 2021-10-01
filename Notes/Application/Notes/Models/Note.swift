//
//  Note.swift
//  Notes
//
//  Created by Dylan on 01/10/2021.
//

import Foundation

struct Note: Identifiable {
  var id: UUID
  var creationDateTime: Date
  var noteContent: String?
}

extension Note : Decodable {
  enum CodingKeys: String, CodingKey {
    case id
    case creationDateTime = "creation_date_time"
    case noteContent = "content"
  }
}
