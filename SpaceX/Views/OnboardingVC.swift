//

import UIKit
import SwiftUI
import Onboarder
import JsHelper

class OnboardingVC: UIViewController {

    let pages = [
        OBPage(
            color: Color(UIColor.systemBlue),
            imageName: "OBLaunches",
            label: ("Launches", "View SpaceX launches information. See their latest, past, upcoming, or next launches and more.")
        ),
        OBPage(
            color: Color(UIColor.systemBlue),
            imageName: "OBCrew",
            label: ("Crew", "See information about all crew members that have gone to space in a Dragon capsule since they started in 2020.")
        ),
        OBPage(
            color: Color(UIColor.systemBlue),
            imageName: "OBVehicles",
            label: ("Vehicles & Pads", "Explore SpaceX's vehicles and pads: Capsules, Rockets, Ships, Landing/Launch pads, and more.")
        ),
        OBPage(
            color: Color(UIColor.systemBlue),
            imageName: "OBCompany",
            label: ("SpaceX", "View all important information about SpaceX, the company, and their most important historical milestones.")
        )
    ]

    let config = OBConfiguration( buttonLabel: "Explore SpaceX", textContentBackgroundColor: Color(UIColor.systemBackground))

    override func viewDidLoad() {
        super.viewDidLoad()

        @TAMIC var onboardingView = UIOnboardingView(frame: .zero, pages: pages, configuration: config) {
            UserDefaults.standard.set(true, forKey: UserDefaults.Keys.hasShownOnboarding.rawValue)
            self.dismiss(animated: true)
        }
        view.addSubview(onboardingView)
        onboardingView.addConstraints(equalTo: view)

        isModalInPresentation = true
    }
}
