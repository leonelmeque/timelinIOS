import UIKit

class TLPinnedTodosSection: UIStackView {

  let header:TLTypography = {
    var title =  TLTypography(title: "Pinned Todo", fontSize: .title, colour:.label, weight: .bold)

    title.translatesAutoresizingMaskIntoConstraints = false
    title.heightAnchor.constraint(equalToConstant: title.font.pointSize * 1.2).isActive = true

    return title
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configuration()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configuration(){
    let pinnedTodo = TLTodoCard(title: "Glovo Cares Initiative", description: "We will expand Glovo Cares to people outside Glovo", colour: .pink, createdAt: "19 Sep. 2023")

    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    distribution = .fill
    spacing = TLSpacing.s8.size

    addArrangedSubview(header)
    addArrangedSubview(pinnedTodo)
  }

}
