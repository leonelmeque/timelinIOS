import UIKit

class HomeVC: UIViewController {
    enum Section: CaseIterable {
        case projects, pinned, recentlyUpdated
    }
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    var todos = [Todo]()
    var pinnedTodos = PinnedTodoSectionView()
    var recentlyChanged = RecentlyChangedSectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setupTableView()
        setupTableHeader()
        fetchTodos()
    }
 
  private func configuration(){
    let searchIcon = UIBarButtonItem(systemItem: .search)
    searchIcon.tintColor = .label
    navigationItem.rightBarButtonItem = searchIcon
  }
    private func setupTableView(){
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TLCarousel.self, forCellReuseIdentifier: TLCarousel.identifier)

        view.addSubview(tableView)
    }

  private func setupTableHeader(){
    let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 500))

    tableView.tableFooterView = tableFooterView
    tableFooterView.addSubview(pinnedTodos)
    tableFooterView.addSubview(recentlyChanged)

    NSLayoutConstraint.activate([
      pinnedTodos.topAnchor.constraint(equalTo: tableFooterView.topAnchor),
      pinnedTodos.leadingAnchor.constraint(equalTo: tableFooterView.leadingAnchor, constant: 16),
      pinnedTodos.trailingAnchor.constraint(equalTo: tableFooterView.trailingAnchor, constant: -16),
      pinnedTodos.heightAnchor.constraint(equalToConstant: 250),

      recentlyChanged.topAnchor.constraint(equalTo: pinnedTodos.bottomAnchor, constant: 12),
      recentlyChanged.leadingAnchor.constraint(equalTo: tableFooterView.leadingAnchor, constant: 16),
      recentlyChanged.trailingAnchor.constraint(equalTo: tableFooterView.trailingAnchor, constant: -16),
      recentlyChanged.heightAnchor.constraint(equalToConstant: 250)
    ])
  }

  private func fetchTodos()  {
    Task {
      if let result = try? await NetworkManager.shared.getAllTodos() {
        DispatchQueue.main.async {
          self.todos.append(contentsOf: result)
          self.tableView.reloadData()
          self.pinnedTodos.setPinnedTodo(model: result)
          self.recentlyChanged.setRecentlyChangedTodo(model: result)
        }
      }
    }
  }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TLCarousel.identifier, for: indexPath) as? TLCarousel else {return UITableViewCell()}
      cell.backgroundColor = .yellow

      cell.initCell(with: todos) { id in
      }

      return cell
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sections:[String] = []
        
        for item in Section.allCases {
            sections.append("\(item)")
        }

        return sections[section]
    }

  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let headerTitle = view as? UITableViewHeaderFooterView else {return}
    headerTitle.textLabel?.text =  headerTitle.textLabel?.text?.capitalizeFirstLetter()
    headerTitle.textLabel?.textColor = .label
    headerTitle.textLabel?.font = .systemFont(ofSize: TLSpacing.s24.size, weight: .bold)
  }
}


#Preview {
    HomeVC()
}
