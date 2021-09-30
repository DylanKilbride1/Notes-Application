//
//  NABaseNavigationController.swift
//  Notes
//
//  Created by Dylan on 28/09/2021.
//

import UIKit

class NABaseNavigationController: UINavigationController {

  override func viewDidLoad() {
      super.viewDidLoad()
      configureLayout()
    }
    
    private func configureLayout() {
      self.view.clipsToBounds = true
      view.backgroundColor = ApplicationColors.appPrimaryColor
    }
    
    //MARK: - Required
    
    override init(rootViewController: UIViewController) {
      super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

}

