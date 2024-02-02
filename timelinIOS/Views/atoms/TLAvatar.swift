import UIKit

class TLAvatar: UIImageView {
    
    var urlImage: String!
    var label: String!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(urlImage: String, label: String?) {
        self.init(frame: .zero)
        self.urlImage = urlImage
        self.label = label
    }
    
    private func configure(){
        layer.cornerRadius = TLSpacing.s8.size
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
    func setSizeContraints(widthAnchor: CGFloat, heightAnchor: CGFloat){
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: widthAnchor),
            self.heightAnchor.constraint(equalToConstant: heightAnchor)
        ])
    }
    
}
