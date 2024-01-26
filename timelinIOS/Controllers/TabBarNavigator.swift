import UIKit

class TabBarNavigator: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTabs()
    }
    
    private func configure() {
        tabBar.tintColor = .label
        UINavigationBar.appearance().tintColor = .systemTeal
    }
    
    
    private func configureTabs() {
        let homeTab = UINavigationController(rootViewController: HomeVC())
        let addTodoTab = UINavigationController(rootViewController: HomeVC())
        let settingsTab = UINavigationController(rootViewController: HomeVC())
        
        homeTab.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "list.clipboard"), tag:0)
        addTodoTab.tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "plus.app"), tag: 1)
        settingsTab.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 2)
        
        setViewControllers([homeTab, addTodoTab, settingsTab], animated: true)
    }
}

#Preview {
    TabBarNavigator()
}
