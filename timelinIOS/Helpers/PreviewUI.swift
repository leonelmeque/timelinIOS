import UIKit

class PreviewUI: UIViewController {
    var subViewsArranged: [UIView]!
    
    init(subViewsArranged: [UIView]){
        super.init(nibName: nil, bundle: nil)
        self.subViewsArranged = subViewsArranged
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let stackView = UIStackView(arrangedSubviews: subViewsArranged)
        
        stackView.axis = .vertical
        stackView.spacing = 16  // Adjust spacing between buttons
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
        ])
    }
}
