//
//  NANotePreviewTableViewCell.swift
//  Notes
//
//  Created by Dylan on 29/09/2021.
//

import UIKit

class NANotePreviewTableViewCell: UITableViewCell {

  @IBOutlet weak var contentPreview: UILabel?
  @IBOutlet weak var creationTimeDate: UILabel?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCellTheme()
    creationTimeDate?.text = "dfewqceqwcfew"
    contentPreview?.text = "Content"
    }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    Bundle.main.loadNibNamed(CellIdentifiers.notesPreviewCellIdentifier, owner: self, options: nil)
    creationTimeDate?.text = "dfewqceqwcfew"
    contentPreview?.text = "Content"
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    Bundle.main.loadNibNamed(CellIdentifiers.notesPreviewCellIdentifier, owner: self, options: nil)
    creationTimeDate?.text = "dfewqceqwcfew"
    contentPreview?.text = "Content"
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10,
                                                                      left: 10,
                                                                      bottom: 10,
                                                                      right: 10))
  }

  func configureCellTheme() {
    contentView.backgroundColor = ApplicationColors.appSecondaryColor
    contentView.layer.cornerRadius = ViewProperties.tableViewCellRadius
  }
  
//  override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//      // Configure the view for the selected state
//    }

}
