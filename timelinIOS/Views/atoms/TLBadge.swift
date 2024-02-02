import UIKit
import SwiftUI

class TLBadge: UIView {
    enum BadgeVariant {
        case colored, simple
    }
    
    var status: TodoStatus!
    var label: String!
    var variant: BadgeVariant!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(status: TodoStatus, label: String, variant: BadgeVariant){
        self.init(frame: .zero)
        self.status = status
        self.label = label
        self.variant = variant
    }
    
    private func configure(){
        layer.cornerRadius = .infinity
        backgroundColor = .systemRed
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 200),
            self.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        frame.size = CGSize(width: 100, height: 200)
        self.backgroundColor = .systemRed
        
        let label = UILabel()
        label.text = "Something"
        addSubview(label)
        
    }
}


#if DEBUG
struct TLBadgePreview: PreviewProvider {
    static var previews: some View {
        TLPresentableView {
            let badge = TLBadge(status: .completed, label: "Completed", variant: .colored)
            let preview = PreviewUI(subViewsArranged: [badge])
            return preview
        }
    }
}
#endif
