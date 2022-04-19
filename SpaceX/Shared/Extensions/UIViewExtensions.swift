//

import UIKit

extension UIView {
    // generate attributed string with icon
    func makeLabel(title: String, text: String, icon: String) -> NSAttributedString {
        let fullString = NSMutableAttributedString()
        fullString.append(NSAttributedString(string: icon))
        fullString.append(NSAttributedString(string: " \(title): ", attributes: [.font: UIFont.systemFont(ofSize: .fontBody, weight: .semibold)]))
        fullString.append(NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.secondaryLabel]))

        return fullString
    }

    func makeCellResizable(with lastItem: UIView) {
        NSLayoutConstraint.activate([
            // make cell resizable
            lastItem.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(.padding))
        ])
    }
}
