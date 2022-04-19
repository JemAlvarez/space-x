//

import UIKit
import JsHelper

class CompanyVC: UIViewController {
    private var companyData: CompanyModel?
    private var historyData: [HistoryModel] = []

    // MARK: - views

    @TAMIC private var companyTableView = CompanyTableView()
    @TAMIC private var historyTableView = HistoryTableView()
    @TAMIC private var ai = UIActivityIndicatorView()

    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Company", "History"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    // MARK: - didLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        addLoadingIndicator()
        fetchData()
    }
}

// MARK: - configuration
extension CompanyVC {
    // add loading indicator
    private func addLoadingIndicator() {
        view.addSubview(ai)
        ai.startAnimating()
        ai.hidesWhenStopped = true

        NSLayoutConstraint.activate([
            ai.heightAnchor.constraint(equalTo: view.heightAnchor),
            ai.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    // configure table view
    private func configureTableViews() {
        navigationItem.titleView = segmentedControl

        // add sub view and constraints for history table view
        view.addSubview(historyTableView)
        historyTableView.addConstraints(equalTo: view)
        
        // add sub view and constraints for company table view
        view.addSubview(companyTableView)
        companyTableView.addConstraints(equalTo: view)
    }

    // selectors
    @objc func segmentedControlDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            view.bringSubviewToFront(companyTableView)
        } else if sender.selectedSegmentIndex == 1 {
            view.bringSubviewToFront(historyTableView)
        }
    }
}

// MARK: - data
extension CompanyVC {
    private func configView() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }

    private func fetchData() {
        Task.init {
            await fetchCompanyData()
            await fetchHistoryData()
            dataDidLoad()
        }
    }

    private func fetchCompanyData() async {
        let companyData: [CompanyModel] = await APIModel.shared.fetch(for: .company)
        if !companyData.isEmpty {
            self.companyData = companyData[0]
        }
    }

    private func fetchHistoryData() async {
        let historyData: [HistoryModel] = await APIModel.shared.fetch(for: .history)
        self.historyData = historyData
    }

    private func dataDidLoad() {
        UIView.animate(withDuration: 0.25) {
            // remove spinner
            self.ai.removeFromSuperview()
            // add tables and segmented control
            self.configureTableViews()
            // add data to tables
            self.companyTableView.companyData = self.companyData
            self.historyTableView.historyData = self.historyData
        }
    }
}
