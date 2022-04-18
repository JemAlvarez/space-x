//

import UIKit
import JsHelper

class CompanyVC: UIViewController {
    private var companyData: CompanyModel? {
        didSet {
            // TODO: Data loaded
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
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        navigationItem.title = "SpaceX"
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
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let label = UILabel()
        label.text = "fl;dsaj f;lasdkj;alsdkf ;lasdkf;asfkjasdf;l kajs;flsjld;fa ;ldsfa;l f; jdflask jdf;alskjf;asdfasjf;kasd;f lkjsadf;l ksdf;l  fsl;d kfj;sad lf;lsadkfasaf ajfj a jskfasf;lakjf;l"
        cell.addSubview(label)
        label.addConstraints(equalTo: cell)
        label.numberOfLines = 0
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
