//

import UIKit
import JsHelper

class CrewVC: UIViewController {
    // MARK: - data
    var crewData: [CrewModel]? {
        didSet {
            guard let crewData = crewData else { return }
            crewCollectionView.crew = crewData.reversed()
            crewCollectionView.reloadData()
        }
    }

    // MARK: - views
    @TAMIC private var crewCollectionView = CrewCollectionView()

    // MARK: - setup
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
}

// MARK: - config
extension CrewVC {
    private func config() {
        // navbar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Crew"

        // collection view
        view.addSubview(crewCollectionView)
        crewCollectionView.addConstraints(equalTo: view)

        // data
        Task.init {
            await fetchData()
        }
    }

    private func fetchData() async {
        crewData = await APIModel.shared.fetch(for: .crew)
    }
}
