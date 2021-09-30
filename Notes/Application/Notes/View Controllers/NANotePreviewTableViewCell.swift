//
//  NANotePreviewTableViewCell.swift
//  Notes
//
//  Created by Dylan on 29/09/2021.
//

import UIKit

class NANotePreviewTableViewCell: UITableViewCell {

  @IBOutlet weak var creationDateTime: UILabel!
  @IBOutlet weak var contentPreview: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCellTheme()
    creationDateTime.text = "dfewqceqwcfew"
    contentPreview.text = "Content"
    }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
  }

  func configureCellTheme() {
    contentView.backgroundColor = ApplicationColors.appSecondaryColor
    contentView.layer.cornerRadius = ViewProperties.tableViewCellRadius
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
    }

}
