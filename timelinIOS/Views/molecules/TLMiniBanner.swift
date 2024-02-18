import UIKit

class TLMiniBanner: UIView {

  enum TLMiniBannerVariant {
    case success, warning, error

    var color: (bgColor: UIColor, textColor: UIColor) {
      switch self {
      case .success :
        return (TLColours.Success.s50.color, TLColours.Success.s500.color)
      case .warning:
       return  (TLColours.Warning.w50.color, TLColours.Warning.w500.color)
      case .error:
       return  (TLColours.Danger.d50.color, TLColours.Danger.d500.color)
      }
    }
  }

  lazy var titletext = TLTypography(title: "", fontSize: .body, weight: .bold)
  lazy var descriptionText = TLTypography(title: "", fontSize: .body, weight: .regular)

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(title: String, description: String, variant: TLMiniBannerVariant ){
    self.init(frame: .zero)
    backgroundColor = variant.color.bgColor
    
    self.titletext.text = title
    self.descriptionText.text = description
    self.titletext.textColor = variant.color.textColor
    self.descriptionText.textColor = variant.color.textColor
    self.descriptionText.lineBreakMode = .byCharWrapping
    self.descriptionText.numberOfLines = 0

    addSubview(titletext)
    addSubview(descriptionText)

    setupLayout()
  }

  private func configure(){
    layer.cornerRadius = TLSpacing.s8.size
    backgroundColor = .none
  }

  private func setupLayout(){
    let padding = TLSpacing.s16.size

    titletext.translatesAutoresizingMaskIntoConstraints = false
    descriptionText.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      titletext.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
      titletext.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
      titletext.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
      //
      descriptionText.topAnchor.constraint(equalTo: titletext.bottomAnchor, constant: TLSpacing.s4.size),
      descriptionText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
      descriptionText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
      descriptionText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
    ])
  }
}

#Preview {
  let stack =  UIStackView(arrangedSubviews: [
    TLMiniBanner(title: "Success", description: "You have succesfully saved your", variant: .success),
    TLMiniBanner(title: "Warning", description: "You have succesfully saved your time", variant: .warning),
    TLMiniBanner(title: "Danger", description: "You have succesfully saved your time", variant: .error)
   ])

  stack.axis = .vertical
  stack.spacing = 16

  return stack
}
