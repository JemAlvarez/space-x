//

import UIKit
import JsHelper

protocol UICollectionViewNavigation {
    func pushViewController(with vc: UIViewController)
}

class CrewVC: UIViewController, UICollectionViewNavigation {
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

    func pushViewController(with vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - config
extension CrewVC {
    private func config() {
        // navbar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Crew"

        // collection view
        crewCollectionView.navigationDelegate = self
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
