//
//  NABaseViewController.swift
//  Notes
//
//  Created by Dylan on 28/09/2021.
//

import UIKit

class NABaseViewController: UIViewController {

  var contentScrollView: UIScrollView!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTheme()
    configureBackButton()
      }
    
    private func configureTheme() {
      self.view.backgroundColor = UIColor.appPrimaryColor
    }
    
    private func configureBackButton() {
      
    }

}
