//

import UIKit
import JsHelper

class CompanyVC: UIViewController {
    private var companyData: CompanyModel?
    private var historyData: [HistoryModel] = []

    // MARK: - views
    @TAMIC private var companyTableView: UITableView = {
        let table = UITableView()
        // register cells
        table.register(CompanyTableCell.self, forCellReuseIdentifier: CompanyTableCell.id)
        // no dividers
        table.separatorColor = .clear
        return table
    }()

    @TAMIC private var historyTableView: UITableView = {
        let table = UITableView()
        return table
    }()

    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Company", "History"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    @TAMIC private var ai = UIActivityIndicatorView()

    // MARK: - didLoad
    override func viewDidLoad() {
        super.viewDidLoad()

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

    private func addSegmentedControl() {
        navigationItem.titleView = segmentedControl
        historyTableView.isHidden = true
    }

    // configure table view
    private func configureTableViews() {
        addSegmentedControl()
        // delegate & datasource
        companyTableView.delegate = self
        companyTableView.dataSource = self
        // add sub view and constraints for company table view
        view.addSubview(companyTableView)
        companyTableView.addConstraints(equalTo: view)
        // add sub view and constraints for history table view
        view.addSubview(historyTableView)
        historyTableView.addConstraints(equalTo: view)
    }

    // selectors
    @objc func segmentedControlDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            companyTableView.isHidden = false
            historyTableView.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            companyTableView.isHidden = true
            historyTableView.isHidden = false
        }
    }
}

// MARK: - delegate
extension CompanyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let companyCell = makeCompanyCell(indexPath: indexPath)
        return companyCell
    }
}

// MARK: - make cells
extension CompanyVC {
    func makeCompanyCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = companyTableView.dequeueReusableCell(withIdentifier: CompanyTableCell.id, for: indexPath)

        if let companyCell = cell as? CompanyTableCell, let companyData = companyData {
            companyCell.setupData(with: companyData)
            return companyCell
        }

        return cell
    }
}

// MARK: - data
extension CompanyVC {
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
            self.ai.removeFromSuperview()
            self.configureTableViews()
        }
    }
}
