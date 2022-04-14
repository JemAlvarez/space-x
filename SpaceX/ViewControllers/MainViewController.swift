//

import UIKit
import JsHelper

class MainViewController: UIViewController {
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "Hello"
        view.addSubview(label)
        label.addConstraints(equalTo: view)

//        APIModel.shared.fetchCapsules(with: "5e9e2c5bf35918ed873b2664") { capsules in
//            self.label.text = "\(capsules[0].status)"
//        }
    }
}
