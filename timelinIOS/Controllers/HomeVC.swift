import UIKit


class HomeVC: UIViewController {
    enum Section: CaseIterable {
        case projects, pinned, recentlyUpdated
    }
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    var todos: [String] = ["ios","react native","figma", "javascript", "CSS3", "NextJs", "Android", "Rust"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
 
    private func setupTableView(){
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(TLCarousel.self, forCellReuseIdentifier: TLCarousel.identifier)
        
        view.addSubview(tableView)
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TLCarousel.identifier, for: indexPath) as? TLCarousel else {return UITableViewCell()}
        
        cell.initCell(with: todos)
        return cell
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sections:[String] = []
        
        for item in Section.allCases {
            sections.append("\(item)")
        }
    
        
        return sections[section]
    }
}


#Preview {
    HomeVC()
}
