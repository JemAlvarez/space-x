//

import UIKit
import JsHelper

class SettingsVC: UIViewController {
    @TAMIC var table = SettingsTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
    }
}

// MARK: - config
extension SettingsVC {
    func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
    }

    func configureTableView() {
        view.addSubview(table)
        table.addConstraints(equalTo: view)
    }
}
