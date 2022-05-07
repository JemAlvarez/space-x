//

import UIKit

class LaunchInfoVC: UIViewController {
    // MARK: - data
    let launch: LaunchModel

    // MARK: - setup
    init(launch: LaunchModel) {
        self.launch = launch
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemOrange
        navigationItem.title = launch.name
    }
}
