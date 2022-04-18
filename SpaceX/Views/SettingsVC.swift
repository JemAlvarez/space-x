//

import UIKit
import JsHelper

class SettingsVC: UIViewController {

    @TAMIC var table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(table)
        table.addConstraints(equalTo: view)

        table.delegate = self
        table.dataSource = self

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "TEST"
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "TEST"
        return cell
    }
}
