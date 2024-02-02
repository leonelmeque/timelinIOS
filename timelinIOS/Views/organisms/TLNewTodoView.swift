import UIKit

protocol ModalViewControllerDelegate: AnyObject {
  func didPerformActionInModal()
}

class TLNewTodoView: UIViewController, UITabBarControllerDelegate {

  weak var delegate: ModalViewControllerDelegate?
  var addNewTodoContainer: UIView!
  var tlNudeTextField: UITextField!
  var addTodoBtn = TLButton(label: "Save", variant: .primary, size: .md)
  var textButton: TLTypography!

  var padding = TLSpacing.s16.size

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    setupKeyboardAvoidanceView()
  }

  private func configure(){
    view.backgroundColor = TLColours.Greys.g50.color.withAlphaComponent(0.5)
    configureAddNewTodoContainer()
    configureNudeTextField()
    configureButtonActions()
  }

  func configureAddNewTodoContainer () {
    addNewTodoContainer = UIView()
    view.addSubview(addNewTodoContainer)

    addNewTodoContainer.backgroundColor = .systemBackground
    addNewTodoContainer.translatesAutoresizingMaskIntoConstraints = false
    addNewTodoContainer.layer.cornerRadius = TLSpacing.s24.size
    addNewTodoContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    NSLayoutConstraint.activate([
      addNewTodoContainer.heightAnchor.constraint(equalToConstant: 200),
      addNewTodoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      addNewTodoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      addNewTodoContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  func configureNudeTextField() {
    tlNudeTextField = UITextField()
    addNewTodoContainer.addSubview(tlNudeTextField)

    tlNudeTextField.translatesAutoresizingMaskIntoConstraints = false
    tlNudeTextField.textAlignment = .left
    tlNudeTextField.placeholder = "Save the world from aliens"
    tlNudeTextField.borderStyle = .none
    tlNudeTextField.font = .systemFont(ofSize: TLSpacing.s16.size, weight: .regular)
      

    NSLayoutConstraint.activate([
      tlNudeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      tlNudeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      tlNudeTextField.topAnchor.constraint(equalTo: addNewTodoContainer.topAnchor, constant: padding),
      tlNudeTextField.heightAnchor.constraint(equalToConstant: 58)
    ])
  }

  func configureButtonActions() {
    let stackContainer = UIStackView()
    textButton = TLTypography(title: "Add description", fontSize: .body, colour: TLColours.Primary.p300.color, weight: .bold )

    textButton.textAlignment = .center

    addTodoBtn.translatesAutoresizingMaskIntoConstraints = false

    stackContainer.translatesAutoresizingMaskIntoConstraints = false
    stackContainer.axis = .horizontal
    stackContainer.distribution = .fillEqually
    stackContainer.alignment = .center

    stackContainer.spacing = TLSpacing.s16.size

    stackContainer.addArrangedSubview(textButton)
    stackContainer.addArrangedSubview(addTodoBtn)

    addNewTodoContainer.addSubview(stackContainer)

    NSLayoutConstraint.activate([
      stackContainer.topAnchor.constraint(equalTo: tlNudeTextField.bottomAnchor, constant: TLSpacing
        .s16.size),
      stackContainer.trailingAnchor.constraint(equalTo: addNewTodoContainer.trailingAnchor, constant: -padding),
      stackContainer.leadingAnchor.constraint(equalTo: addNewTodoContainer.leadingAnchor, constant:  100)
    ])
  }


}


#Preview {
    TLNewTodoView()
}
