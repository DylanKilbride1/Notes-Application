//
//  NAUserNotesViewController.swift
//  Notes
//
//  Created by Dylan on 28/09/2021.
//

import UIKit

class NAUserNotesViewController: NABaseViewController {
  
  @IBOutlet weak var notesPreviewTableView: UITableView!
  @IBOutlet weak var noNotesLabel: UILabel!
  var existingNotes = [Note]()
  let noteViewModel = NANoteViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTheme()
    configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    populateNotesArray()
  }
  
  func configureTheme() {
    view.backgroundColor = ApplicationColors.appPrimaryColor
    self.navigationController?.isNavigationBarHidden = false
    noNotesLabel.text = NSLocalizedString("home.no.notes.available.message", comment: "")
    navigationItem.title = NSLocalizedString("home.navigation.controller.title", comment: "")
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("home.navigation.controller.add.notes", comment: ""),
                                                        style: .plain, target: self,
                                                        action: #selector(addTapped))
  }
  
  private func populateNotesArray() {
    existingNotes = noteViewModel.retrieveAllNotes(remoteRetreiveCompletion: { (remoteNotes) in
      //merge local w/ remote notes
    })
    existingNotes = existingNotes.sorted(by: { $0.creationDateTime.compare($1.creationDateTime) == .orderedDescending })
    existingNotes.count == 0 ? displayNoNotesMessage() : showTableView()
    notesPreviewTableView.reloadData()
  }
  
  private func displayNoNotesMessage() {
    notesPreviewTableView.isHidden = true
    noNotesLabel.isHidden = false
  }
  
  private func showTableView() {
    notesPreviewTableView.isHidden = false
    noNotesLabel.isHidden = true
  }
  
  @objc private func addTapped() {
    let addNoteViewController = NANoteEditorViewController()
    self.navigationController?.pushViewController(addNoteViewController, animated: true)
  }

  func configureTableView() {
    setTableViewDelegates()
    registerTableViewCells()
    notesPreviewTableView.backgroundColor = ApplicationColors.appPrimaryColor
    notesPreviewTableView.separatorColor = UIColor.clear
  }
  
  func setTableViewDelegates() {
    notesPreviewTableView.delegate = self
    notesPreviewTableView.dataSource = self
  }
  
  private func registerTableViewCells() {
    let textFieldCell = UINib(nibName: CellIdentifiers.notesPreviewCellIdentifier, bundle: nil)
    self.notesPreviewTableView.register(textFieldCell,
                                        forCellReuseIdentifier: CellIdentifiers.notesPreviewCellIdentifier)
  }
}

extension NAUserNotesViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.notesPreviewCellIdentifier) as? NANotesPreviewCell {
      let noteModel = existingNotes[indexPath.row]
      cell.notePreviewText.text = noteModel.noteContent
      cell.noteCreationDate.text = noteViewModel.formatDate(date: noteModel.creationDateTime)
      return cell
    }

    return UITableViewCell()
  }
      
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return existingNotes.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let editNote = NANoteEditorViewController(noteData: existingNotes[indexPath.row])
    self.navigationController?.pushViewController(editNote, animated: true)
    //noteViewModel.noteInUse = existingNotes[indexPath.row].noteContent
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      noteViewModel.deleteExistingNote(noteToDelete: existingNotes[indexPath.row])
      existingNotes.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }
  
}
