//

import UIKit

extension UITableViewCell {
    func makeCellResizable(with lastItem: UIView) {
        NSLayoutConstraint.activate([
            // make cell resizable
            lastItem.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(.padding / 2))
        ])
    }
}
