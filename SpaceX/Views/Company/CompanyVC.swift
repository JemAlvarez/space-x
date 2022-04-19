//

import UIKit
import JsHelper

class CompanyVC: UIViewController {
    private var companyData: CompanyModel?
    private var historyData: [HistoryModel] = []

    // MARK: - views
    @TAMIC private var tableView: UITableView = {
        let table = UITableView()
        // register cells
        table.register(CompanyTableCell.self, forCellReuseIdentifier: CompanyTableCell.id)
        // no dividers
        table.separatorColor = .clear
        return table
    }()

    @TAMIC private var ai = UIActivityIndicatorView()

    // MARK: - didLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        addLoadingIndicator()
        fetchData()
        configureView()
    }
}

// MARK: - configuration
extension CompanyVC {
    // configure company view
    private func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Company"
    }

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
        ai.removeFromSuperview()
        configureTableView()
    }
}
