//

import UIKit
import JsHelper

class CompanyTableView: UITableView {
    var companyData: CompanyModel?

    required init() {
        super.init(frame: .zero, style: .plain)
        config()
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}

// MARK: - config
extension CompanyTableView {
    private func config() {
        // register cells
        register(CompanyTableCell.self, forCellReuseIdentifier: CompanyTableCell.id)
        // no dividers
        separatorColor = .clear
        // delegate & datasource
        delegate = self
        dataSource = self
        // bottom padding
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: .padding * 2, right: 0)
    }
}

// MARK: - delegate
extension CompanyTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let companyCell = makeCompanyCell(indexPath: indexPath)
        return companyCell
    }
}

// MARK: - make cells
extension CompanyTableView {
    private func makeCompanyCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CompanyTableCell.id, for: indexPath)

        if let companyCell = cell as? CompanyTableCell, let companyData = companyData {
            companyCell.companyData = companyData
            return companyCell
        }

        return cell
    }
}
