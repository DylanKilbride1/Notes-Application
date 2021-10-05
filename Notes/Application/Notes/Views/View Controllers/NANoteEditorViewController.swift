//
//  NANoteEditorViewController.swift
//  Notes
//
//  Created by Dylan on 30/09/2021.
//

import UIKit

class NANoteEditorViewController: NABaseViewController {
  
  var noteData: Note
  var isExistingNote = false
  var noteViewModel = NANoteViewModel()
  @IBOutlet weak var textEditingField: UITextView!
  
  init(noteData: Note) {
    self.noteData = noteData
    
    isExistingNote = true
    
    super.init(nibName: ViewControllers.editNotesViewController, bundle: nil)
  }
  
  init() {
    self.noteData = Note(id: UUID(), creationDateTime: Date(), noteContent: "")
    super.init(nibName: ViewControllers.editNotesViewController, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTheme()
    configureEditingField()
  }

  private func configureEditingField() {
    if let noteContent = noteData.noteContent {
      textEditingField.text = noteContent
    } else {
      textEditingField.text = ""
    }
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
    if !hasNoteBeenEdited() {
      navigationController?.popViewController(animated: true)
    } else {
      //display lose changes alert
    }
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func doneTapped() {
    if !hasNoteBeenEdited() {
      navigationController?.popViewController(animated: true)
    } else {
      if isExistingNote {
        noteViewModel.updateExistingNote(noteToUpdate: noteData,
                                         updatedContent: textEditingField.text)
        navigationController?.popViewController(animated: true)
      } else {
        let noteUUID = UUID.init()
        let noteContent = textEditingField.text
        let created = Date()
        noteViewModel.createNewNote(noteData: Note(id: noteUUID,
                                                   creationDateTime: created,
                                                   noteContent: noteContent ?? ""))
        navigationController?.popViewController(animated: true)
      }
    }
  }
  
  private func hasNoteBeenEdited() -> Bool {
    if noteData.noteContent == textEditingField.text {
      return false
    } else {
      return true
    }
  }
  
  //required
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
