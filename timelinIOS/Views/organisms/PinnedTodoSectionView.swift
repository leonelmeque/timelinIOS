import UIKit

class PinnedTodoSectionView: UIView {

  var headerSection = TLTypography(title: "Pinned Todo", fontSize: .title, colour: .label, weight: .bold)
  var pinnedTodo: TLTodoCard = TLTodoCard()
  private lazy var pinnedTodoId: String = ""

  override init(frame: CGRect) {
      super.init(frame: frame)
      configuration()

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configuration(){
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(headerSection)

    configureHeader()
    fetchPinnedTodo()
    configurePinnedTodo()
  }

  private func configureHeader() {
    headerSection.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      headerSection.topAnchor.constraint(equalTo: topAnchor),
      headerSection.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerSection.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  private func configurePinnedTodo(){
    addSubview(pinnedTodo)
    pinnedTodo.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pinnedTodo.topAnchor.constraint(equalTo: headerSection.bottomAnchor, constant: TLSpacing.s8.size),
      pinnedTodo.leadingAnchor.constraint(equalTo: leadingAnchor),
      pinnedTodo.trailingAnchor.constraint(equalTo: trailingAnchor),
      pinnedTodo.heightAnchor.constraint(equalToConstant: 200)
    ])
  }

  private func fetchPinnedTodo(){
    Task {
      let data = try await NetworkManager.shared.getPinnedAndRecentlyChangedTodo()
      pinnedTodoId = data?.pinnedTodo ?? ""
    }
  }

  func setPinnedTodo(model: [Todo]){
    if let todo = model.first(where: {$0.id == pinnedTodoId}) {
      DispatchQueue.main.async {
        self.pinnedTodo.setTodo(title: todo.todo, description: todo.description, colour: .pink, createdAt: Date.dateFormatter(from: Double(todo.timestamp)))
      }
    }
  }
}
