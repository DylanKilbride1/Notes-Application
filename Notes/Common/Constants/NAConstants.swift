//
//  NAConstants.swift
//  Notes
//
//  Created by Dylan on 28/09/2021.
//

import Foundation
import UIKit
  

struct ViewProperties {
  static let tableViewCellRadius = 2.0
  static let noteTableViewCellPreviewHeight = 80.0
}

struct CellIdentifiers {
  static let notesPreviewCellIdentifier = "NANotesPreviewCell"
}
  
struct ApplicationColors {
  static let appPrimaryColor = UIColor.init(named: "appPrimaryColor")
  static let appSecondaryColor = UIColor.init(named: "appSecondaryColor")
  static let noteTextAreaColor = UIColor.init(named: "noteTextColor")

}

struct NetworkProperties {
  static let baseUrl = "https://www.myapi.com/"
}

  
