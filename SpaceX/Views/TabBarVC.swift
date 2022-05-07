//

import UIKit
import JsHelper

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    private let tabs: [String] = ["Launches", "Crew", "Vehicles", "Company", "Settings"]

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        setViewControllers(getTabViewControllers(), animated: true)
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
//        let vcs = [crewVC, vehiclesVC, companyVC, launchesVC, settingsVC]

        // set VCs titles
        for i in 0..<tabs.count {
            vcs[i].tabBarItem.title = tabs[i]
            vcs[i].tabBarItem.image = UIImage(named: tabs[i].lowercased())
            vcs[i].tabBarItem.tag = i
        }

        return vcs
    }
}

// MARK: - delegate
extension TabBarVC {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.tabBarItem.tag == 3 {
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = UITabBarAppearance()
            }
        } else {
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                appearance.configureWithTransparentBackground()
                tabBar.scrollEdgeAppearance = appearance
            }
        }
    }
}
