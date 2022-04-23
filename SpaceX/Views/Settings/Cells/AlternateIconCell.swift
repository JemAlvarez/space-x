//

import UIKit
import JsHelper

class AlternateIconCell: UITableViewCell {

    static let id = "AlternateIconCell"

    var imageName: String = ""

    // MARK: - views
    @TAMIC private var iconImageView = UIImageView()
    @TAMIC private var iconNameLabel = UILabel()

    // MARK: - setup
    required init(imageName: String) {
        super.init(style: .default, reuseIdentifier: nil)
        self.imageName = imageName

        displayUI()
        makeCellResizable(with: iconImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}

// MARK: - ui
extension AlternateIconCell {
    // display ui
    private func displayUI() {
        displayIcon()
        displayLabel()
    }

    // display icon
    private func displayIcon() {
        addSubview(iconImageView)
        iconImageView.backgroundColor = .tertiarySystemBackground
        iconImageView.layer.cornerRadius = .cornerRadius
        iconImageView.clipsToBounds = true
        iconImageView.image = UIImage(named: imageName)

        let heightAnchor = iconImageView.heightAnchor.constraint(equalToConstant: 65)
        heightAnchor.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 65),
            heightAnchor
        ])
    }

    // label
    private func displayLabel() {
        addSubview(iconNameLabel)
        iconNameLabel.text = imageName
        iconNameLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .systemFont(ofSize: .fontBody, weight: .semibold))

        NSLayoutConstraint.activate([
            iconNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: .padding)
        ])
    }
}
