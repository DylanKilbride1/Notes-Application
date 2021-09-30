//
//  NANoteEditorViewController.swift
//  Notes
//
//  Created by Dylan on 30/09/2021.
//

import UIKit

class NANoteEditorViewController: NABaseViewController {
  
  @IBOutlet weak var textEditingField: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTheme()
  }

  private func configureTheme() {
    view.backgroundColor = ApplicationColors.appPrimaryColor
    self.navigationController?.isNavigationBarHidden = false
    navigationItem.title = NSLocalizedString("edit.note.navigation.controller.title", comment: "")
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    
    textEditingField.backgroundColor = ApplicationColors.appPrimaryColor
    textEditingField.textColor = ApplicationColors.noteTextAreaColor
  }
  
  @objc private func cancelTapped() {
//    if noteModel.noteContent == textEditingField.text {
//      navigationController?.popViewController(animated: true)
//    } else {
//      //display lose changes alert
//    }
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func doneTapped() {}

}
