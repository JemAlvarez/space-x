//

import UIKit
import JsHelper

class TabBarVC: UITabBarController {
    private let tabs: [String] = ["Launches", "Crew", "Vehicles", "Company", "Settings"]

    override func viewDidLoad() {
        super.viewDidLoad()

        removeScrollEdgeAppearance()

        setViewControllers(getTabViewControllers(), animated: true)

        UserDefaults.standard.reset(for: [UserDefaults.Keys.hasShownOnboarding.rawValue])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        displayOnboarding()
    }
}

// MARK: - extensions
extension TabBarVC {
    // MARK: - show onboarding
    func displayOnboarding() {
        let hasShownOnboarding = UserDefaults.standard.bool(forKey: UserDefaults.Keys.hasShownOnboarding.rawValue)
        
        if !hasShownOnboarding {
            present(OnboardingVC(), animated: true)
        }
    }

    // MARK: - remove scroll edge appearance
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
