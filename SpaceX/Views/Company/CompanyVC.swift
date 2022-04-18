//

import UIKit
import JsHelper

class CompanyVC: UIViewController {
    private var companyData: CompanyModel? {
        didSet {
            tableView.reloadData()
        }
    }
    private var historyData: [HistoryModel] = [] {
        didSet {
            // TODO: Data loaded
        }
    }

    // MARK: - views
    @TAMIC private var tableView: UITableView = {
        let table = UITableView()
        // register cells
        table.register(CompanyTableCell.self, forCellReuseIdentifier: CompanyTableCell.id)
        // no dividers
        table.separatorColor = .clear
        return table
    }()

    // MARK: - didLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        configureView()
        configureTableView()
    }
}

// MARK: - configuration
extension CompanyVC {
    // configure company view
    private func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Company"
    }

    // configure table view
    private func configureTableView() {
        // delegate & datasource
        tableView.delegate = self
        tableView.dataSource = self
        // add sub view and constraints
        view.addSubview(tableView)
        tableView.addConstraints(equalTo: view)
    }
}

// MARK: - delegate
extension CompanyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let companyCell = makeCompanyCell(indexPath: indexPath)
        return companyCell
    }
}

// MARK: - make cells
extension CompanyVC {
    func makeCompanyCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTableCell.id, for: indexPath)

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
}
