//
//  TLCustomDateTextField.swift
//  timelinapp
//
//  Created by Leonel Meque on 6/2/24.
//

import UIKit

class TLCustomDateTextField: UITextField {

  var label: String!
  let padding:CGFloat = TLSpacing.s16.size


  override init (frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  convenience init(label: String, color: UIColor) {
    self.init()
    self.label = label
    self.backgroundColor = color
    self.placeholder = "Add a date"
    self.text = label
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = TLSpacing.s8.size
    font = UIFont.systemFont(ofSize: TLSpacing.s16.size, weight: .bold)

  }

  override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: padding , dy: padding)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: padding, dy: padding)
  }

}
