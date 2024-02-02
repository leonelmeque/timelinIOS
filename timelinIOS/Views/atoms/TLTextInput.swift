import UIKit
import SwiftUI

class TLTextInput: UITextField {
    
    let padding:CGFloat = TLSpacing.s16.size

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 8
        layer.borderWidth = 1;
        layer.borderColor = TLColours.Greys.g500.color.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        adjustsFontSizeToFitWidth = true
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        minimumFontSize = TLSpacing.s16.size - 2
        font = UIFont.preferredFont(forTextStyle: .body)
        
        placeholder = "Placeholder"
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding , dy: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }
    
    func setupConstraints(in view: UIView, spacing: CGFloat) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            heightAnchor.constraint(equalToConstant: TLSpacing.s64.size)
        ])
    }
}


#if DEBUG
#Preview {
    TLTextInput()
}
#endif
