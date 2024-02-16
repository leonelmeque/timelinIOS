import UIKit
import SwiftUI

enum ButtonVariant {
    case primary
    case secondary
    case tertiary
    case disabled
}

enum ButtonSize {
    case md
    case lg
    case sm
}

class TLButton: UIButton {

  var variant: ButtonVariant! {
    didSet {
      configureVariant()
    }
  }
    var size: ButtonSize!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                fadeTo(0.5, duration: 0.1)
            } else {
                fadeTo(1.0, duration: 0.1)
            }
        }
    }
    
    convenience init (label: String, variant: ButtonVariant, size: ButtonSize){
        self.init(frame: .zero)
        
        self.variant = variant
        self.size = size
        self.setTitle(label, for: .normal)
        
        configureSize()
        configureVariant()
    }
    
    private func configure(){
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel?.adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSize(){
        switch size {
            case .sm:
                layer.cornerRadius = 2
                NSLayoutConstraint.activate([
                    heightAnchor.constraint(equalToConstant: 16 * 2)])
            case .md:
                layer.cornerRadius = 4
                NSLayoutConstraint.activate([
                    heightAnchor.constraint(equalToConstant: 24 * 2)])
            case .lg:
                layer.cornerRadius = 8
                NSLayoutConstraint.activate([
                    heightAnchor.constraint(equalToConstant: 32 * 2)])
            case .none:
                break
        }
    }
    
    private func configureVariant(){
        switch variant {
            case .primary:
                self.backgroundColor = TLColours.Primary.p300.color
            case .secondary:
                self.backgroundColor = TLColours.Primary.p75.color
            case .tertiary:
                self.backgroundColor = .darkGray
            case .disabled:
                self.backgroundColor = TLColours.Greys.g50.color
            case .none:
                break
        }
    }

    func setVariant(_ variant: ButtonVariant) {
         self.variant = variant
     }

    private func fadeTo(_ alpha:CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
}

#if DEBUG
struct TLButtonPreview: PreviewProvider {
    static var previews: some View {
        TLPresentableView {
            let primaryBtn = TLButton(label: "Primary", variant: .primary, size: .lg)
            let secondaryBtn = TLButton(label: "Secondary", variant: .secondary, size: .lg)
            let disabledBtn = TLButton(label: "Disabled", variant: .disabled, size: .lg)
            
            return PreviewUI(subViewsArranged: [primaryBtn, secondaryBtn, disabledBtn])
        }
    }
}
#endif

