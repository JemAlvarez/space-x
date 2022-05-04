//

import UIKit
import JsHelper

class HistoryTableView: UITableView {
    var historyData: [HistoryModel] = []

    required init() {
        super.init(frame: .zero, style: .insetGrouped)
        config()
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}

// MARK: - config
extension HistoryTableView {
    private func config() {
        // register cells
        register(HistoryTableCell.self, forCellReuseIdentifier: HistoryTableCell.id)
        // delegate & datasource
        delegate = self
        dataSource = self
    }
}

// MARK: - delegate
extension HistoryTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let companyCell = makeHistoryCell(indexPath: indexPath)
        return companyCell
    }
}

// MARK: - make cells
extension HistoryTableView {
    private func makeHistoryCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: HistoryTableCell.id, for: indexPath)

        if let historyCell = cell as? HistoryTableCell {
            historyCell.historyData = historyData.reversed()[indexPath.row]
            return historyCell
        }

        return cell
    }
}
