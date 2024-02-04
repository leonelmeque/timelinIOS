import UIKit

class RecentlyChangedSectionView: UIView {

  var headerSection = TLTypography(title: "Recently Changed", fontSize: .title, colour: .label, weight: .bold)
  var recentlyChangedTodo: TLTodoCard = TLTodoCard()
  private lazy var recentlyChangedTodoId: String = ""

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
    fetchRecentlyChangedTodo()
    configureRecentlyChangedTodo()
  }

  private func configureHeader() {
    headerSection.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      headerSection.topAnchor.constraint(equalTo: topAnchor),
      headerSection.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerSection.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  private func configureRecentlyChangedTodo(){
    addSubview(recentlyChangedTodo)
    recentlyChangedTodo.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      recentlyChangedTodo.topAnchor.constraint(equalTo: headerSection.bottomAnchor, constant: TLSpacing.s8.size),
      recentlyChangedTodo.leadingAnchor.constraint(equalTo: leadingAnchor),
      recentlyChangedTodo.trailingAnchor.constraint(equalTo: trailingAnchor),
      recentlyChangedTodo.heightAnchor.constraint(equalToConstant: 200)
    ])
  }

  private func fetchRecentlyChangedTodo(){
    Task {
      let data = try await NetworkManager.shared.getPinnedAndRecentlyChangedTodo()
      recentlyChangedTodoId = data?.latestChanged ?? ""
    }
  }

  func setRecentlyChangedTodo(model: [Todo]){
    if let todo = model.first(where: {$0.id == recentlyChangedTodoId}) {
      DispatchQueue.main.async {
        self.recentlyChangedTodo.setTodo(title: todo.todo, description: todo.description, colour: .pink, createdAt: Date.dateFormatter(from: Double(todo.timestamp)))
      }
    }
  }
}
