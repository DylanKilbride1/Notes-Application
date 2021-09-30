//
//  NAUserNotesViewController.swift
//  Notes
//
//  Created by Dylan on 28/09/2021.
//

import UIKit

class NAUserNotesViewController: NABaseViewController {
  
  @IBOutlet weak var notesPreviewTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTheme()
    configureTableView()
  }
  
  func configureTheme() {
    view.backgroundColor = ApplicationColors.appPrimaryColor
    self.navigationController?.isNavigationBarHidden = false
    navigationItem.title = NSLocalizedString("home.navigation.controller.title", comment: "")
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("home.navigation.controller.add.notes", comment: ""),
                                                        style: .plain, target: self,
                                                        action: #selector(addTapped))
  }
  
  @objc private func addTapped() {
    
  }

  func configureTableView() {
    setTableViewDelegates()
    registerTableViewCells()
    notesPreviewTableView.backgroundColor = ApplicationColors.appPrimaryColor
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
      return cell
    }

    return UITableViewCell()
  }
      
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let editNote = NANoteEditorViewController()
    self.navigationController?.pushViewController(editNote, animated: true)
  }
  
}
