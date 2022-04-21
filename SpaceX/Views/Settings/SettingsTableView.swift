//

import UIKit

class SettingsTableView: UITableView {

    required init() {
        super.init(frame: .zero, style: .insetGrouped)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("No NSCoder available.")
    }
}

// MARK: - table view delegates
extension SettingsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "TEST"
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header \(section)"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}

// MARK: - config
extension SettingsTableView {
    private func configure() {
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.delegate = self
        self.dataSource = self
    }
}
