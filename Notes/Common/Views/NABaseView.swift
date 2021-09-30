//
//  NABaseView.swift
//  Notes
//
//  Created by Dylan on 28/09/2021.
//

import UIKit

class NABaseView: UIView {

required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  private func commonInit() {
    let view = Bundle.main.loadNibNamed(xibName(), owner: self, options: nil)?.first as! UIView
    view.translatesAutoresizingMaskIntoConstraints = false;
    self.addSubview(view)
    pinViewToSuperViewEdges(view: view)
  }
  
  private func xibName() -> String {
    let className: String = NSStringFromClass(type(of: self))
    return className.components(separatedBy: ".").last!
  }
  
  private func pinViewToSuperViewEdges(view: UIView) {
    view.heightAnchor.constraint(equalTo: view.superview!.heightAnchor).isActive = true
    view.widthAnchor.constraint(equalTo: view.superview!.widthAnchor).isActive = true
    view.centerXAnchor.constraint(equalTo: view.superview!.centerXAnchor).isActive = true
    view.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor).isActive = true
  }
}
