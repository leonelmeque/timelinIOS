import Foundation
import UIKit

extension UINavigationController {
  func removeViewController(_ controller: UIViewController.Type) {
    if let vc = viewControllers.first(where: {$0.isKind(of: controller.self)}) {
      vc.removeFromParent()
    }
  }
}
