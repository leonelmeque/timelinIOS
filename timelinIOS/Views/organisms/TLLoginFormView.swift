import UIKit

class TLLoginFormView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure(){
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = TLSpacing.s24.size
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
