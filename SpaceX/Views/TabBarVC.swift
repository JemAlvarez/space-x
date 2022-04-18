//

import UIKit

class TabBarVC: UITabBarController {
    private let tabs: [String] = ["launches", "crew", "vehicles", "company", "settings"]

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = getTabViewControllers()
    }
}

// MARK: - extensions
extension TabBarVC {
    // MARK: - return tab VCs
    func getTabViewControllers() -> [UIViewController] {
        // Launches
        let launchesVC = LaunchesVC()
        // Crew
        let crewVC = CrewVC()
        // Vehicles: capsules, cores, dragons, landpads, launchpads, payloads, roadster, rockets, ships
        let vehiclesVC = VehiclesVC()
        // Company: Company, History
        let companyVC = CompanyVC()
        // Settings
        let settingsVC = SettingsVC()

        // all VCs
        let vcs = [launchesVC, crewVC, vehiclesVC, companyVC, settingsVC]

        // set VCs titles
        for i in 0..<tabs.count {
            vcs[i].tabBarItem.title = tabs[i].capitalized
            vcs[i].tabBarItem.image = UIImage(named: tabs[i])
            vcs[i].tabBarItem.tag = i
        }

        return vcs
    }
}
