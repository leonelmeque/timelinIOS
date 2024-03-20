import UIKit
import RxSwift
import RxCocoa

class TLBadge: UIView {
    enum BadgeVariant {
        case colored, simple
    }

  lazy var badgeStatus: TLTypography = TLTypography(title: "TODO", fontSize: .body, colour: TLColours.Primary.p50.color, weight: .bold)
   var status: TodoStatus!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(status: TodoStatus, variant: BadgeVariant){
      self.init(frame: .zero)
      self.status = status
      setupElements(by: status, and: variant)
    }
    
    private func configure(){
      let padding = TLSpacing.s8.size

      layer.cornerRadius = TLSpacing.s4.size
      translatesAutoresizingMaskIntoConstraints = false

      addSubview(badgeStatus)

      UIHelper.toCenter(this: badgeStatus, into: self) {
        return (padding, padding, padding, -padding)
      }
    }
  
  private func setupElements(by status: TodoStatus, and variant: BadgeVariant = .colored){
    badgeStatus.textAlignment = .center
    badgeStatus.text = "\(String(describing: status))".uppercased()

    if variant == .colored {
      badgeStatus.textColor = textColorBy(status: status)
      backgroundColor = bgColorBy(status: status)
    } else {
      badgeStatus.textColor = TLColours.Neutrals.dark.color
      backgroundColor = TLColours.Neutrals.white.color
      layer.cornerRadius = 8
    }
  }

   private func bgColorBy(status: TodoStatus) -> UIColor {
    switch status {
      case .completed :
        return BadgeUIColor.completed.color
      case .on_going:
        return BadgeUIColor.on_going.color
      case .on_hold:
        return BadgeUIColor.on_hold.color
      case .todo:
        return BadgeUIColor.todo.color
    }
  }

  private func textColorBy(status: TodoStatus) -> UIColor {
    switch status {
      case .completed :
        return BadgeTextColor.completed.color
      case .on_going:
        return BadgeTextColor.on_going.color
      case .on_hold:
        return BadgeTextColor.on_hold.color
      case .todo:
        return BadgeTextColor.todo.color
    }
  }

  private func setStatus(to newStatus: TodoStatus) {
    setupElements(by: newStatus)
  }
}


#if DEBUG
import SwiftUI

#Preview("Colored"){
  let badge = TLBadge(status: .completed, variant: .colored)

  return badge
}

#Preview("Simple"){
  let badge = TLBadge(status: .completed, variant: .simple)
  let view = UIView()
  view.backgroundColor = .gray
  view.addSubview(badge)

  NSLayoutConstraint.activate([
    badge.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    badge.centerXAnchor.constraint(equalTo: view.centerXAnchor)
  ])
  return view
}
#endif
