//

import UIKit

class TabBarVC: UITabBarController {
    private let tabs: [String] = ["Launches", "Crew", "Vehicles", "Company", "Settings"]

    override func viewDidLoad() {
        super.viewDidLoad()

        removeScrollEdgeAppearance()

        setViewControllers(getTabViewControllers(), animated: true)
    }
}

// MARK: - extensions
extension TabBarVC {
    func removeScrollEdgeAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }

    // MARK: - return tab VCs
    func getTabViewControllers() -> [UIViewController] {
        // Launches
        let launchesVC = UINavigationController(rootViewController: LaunchesVC())
        // Crew
        let crewVC = UINavigationController(rootViewController: CrewVC())
        // Vehicles: capsules, cores, dragons, landpads, launchpads, payloads, roadster, rockets, ships
        let vehiclesVC = UINavigationController(rootViewController: VehiclesVC())
        // Company: Company, History
        let companyVC = UINavigationController(rootViewController: CompanyVC())
        // Settings
        let settingsVC = UINavigationController(rootViewController: SettingsVC())

        // all VCs
        let vcs = [launchesVC, crewVC, vehiclesVC, companyVC, settingsVC]
//        let vcs = [settingsVC, crewVC, vehiclesVC, companyVC, launchesVC]

        // set VCs titles
        for i in 0..<tabs.count {
            vcs[i].tabBarItem.title = tabs[i]
            vcs[i].tabBarItem.image = UIImage(named: tabs[i].lowercased())
            vcs[i].tabBarItem.tag = i
        }

        return vcs
    }
}
