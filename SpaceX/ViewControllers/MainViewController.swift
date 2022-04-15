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

        APIModel.shared.fetchCompany { company in
            self.label.text = company.cto_propulsion
        }
    }
}
