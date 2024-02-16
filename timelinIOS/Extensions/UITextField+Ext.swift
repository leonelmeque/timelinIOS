
import UIKit
import Combine

extension UITextField {
  var textPublisher: AnyPublisher<String, Never> {
    return NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self).map {notification in
      return (notification.object as? UITextField)?.text ?? ""
    }.eraseToAnyPublisher()
  }
}
