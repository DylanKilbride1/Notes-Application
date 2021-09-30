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
    navigationItem.title = NSLocalizedString("", comment: "home.navigation.controller.title")
  }

  func configureTableView() {
    view.addSubview(notesPreviewTableView)
    setTableViewDelegates()
    notesPreviewTableView.rowHeight = ViewProperties.noteTableViewCellPreviewHeight
    notesPreviewTableView.backgroundColor = ApplicationColors.appPrimaryColor
    notesPreviewTableView.register(NANotePreviewTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.notesPreviewCellIdentifier)
  }
  
  func setTableViewDelegates() {
    notesPreviewTableView.delegate = self
    notesPreviewTableView.dataSource = self
  }
}


extension NAUserNotesViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
    //How many cells will it show
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.notesPreviewCellIdentifier) as! NANotePreviewTableViewCell
    
    return cell
    //What cells is it showing
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("You tapped cell number \(indexPath.row).")
  }
  
}
