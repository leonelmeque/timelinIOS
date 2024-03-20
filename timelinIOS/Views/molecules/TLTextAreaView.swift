import UIKit
import RxSwift
import RxCocoa

class TLTextAreaView: UITextView {

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    self.delegate = self
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    self.font = UIFont.systemFont(ofSize: 16)
    self.backgroundColor = UIColor.gray.withAlphaComponent(0.05)
    self.layer.cornerRadius = 8
  }
}

extension TLTextAreaView: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    let size = CGSize(width: textView.frame.size.width, height: .infinity)
    let estimatedSize = textView.sizeThatFits(size)

    guard textView.contentSize.height < 100.0 else { textView.isScrollEnabled = true; return }

    textView.isScrollEnabled = false
    textView.constraints.forEach { (constraint) in
      if constraint.firstAttribute == .height {
        constraint.constant = estimatedSize.height
      }
    }
  }
}



#Preview {
  let textArea = TLTextAreaView()
  let container = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
  container.addSubview(textArea)
  container.backgroundColor = .systemBackground


  textArea.translatesAutoresizingMaskIntoConstraints = false
  textArea.heightAnchor.constraint(equalToConstant: 50).isActive = true
  textArea.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
  textArea.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
  textArea.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

  return container
}
