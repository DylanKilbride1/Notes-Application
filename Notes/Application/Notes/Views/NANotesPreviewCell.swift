//
//  NANotesPreviewCell.swift
//  Notes
//
//  Created by Dylan on 30/09/2021.
//

import UIKit

class NANotesPreviewCell: UITableViewCell {
  @IBOutlet weak var noteContentView: UIView!
  @IBOutlet weak var notePreviewText: UILabel!
  @IBOutlet weak var noteCreationDate: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCellTheme()
  }
  
  private func configureCellTheme() {
    contentView.backgroundColor = ApplicationColors.appPrimaryColor
    noteContentView.layer.cornerRadius = 15
    noteContentView.clipsToBounds = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
