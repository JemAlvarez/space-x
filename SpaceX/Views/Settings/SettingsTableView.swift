//

import UIKit
import JsHelper

class SettingsTableView: UITableView {

    private let icons = ["SN 420 Unstacked", "SN 420 Stacked"]

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
        if section == 0 {
            return icons.count
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 1
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = AlternateIconCell(imageName: icons[indexPath.row])
            return cell
        } else if indexPath.section == 1 {
            var cell = UITableViewCell()

            if indexPath.row == 0 {
                cell = makeLabelCell(icon: "star.fill", text: "Rate on App Store", backgroundColor: .systemYellow)
            } else if indexPath.row == 1 {
                cell = makeLabelCell(icon: "person.crop.circle.fill.badge.checkmark", text: "Follow me on Twitter", backgroundColor: .systemBlue)
            }

            return cell
        } else if indexPath.section == 2 {
            return makeLabelCell(icon: "globe", text: "SpaceX API", backgroundColor: .systemTeal)
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "App Icon"
        case 1:
            return "Support"
        case 2:
            return "Credits"
        default:
            return nil
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                UIApplication.shared.setAlternateIconName(nil)
            case 1:
                UIApplication.shared.setAlternateIconName("AppIcon1")
            default:
                break
            }
        } else {
            openLink(for: indexPath)
        }
    }
}

// MARK: - open link
extension SettingsTableView {
    func openLink(for indexPath: IndexPath) {
         if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                guard let url = URL(string: .rateOnAppStoreLink(with: App.appId)) else {break}
                UIApplication.shared.open(url)
            case 1:
                guard let url = URL(string: "https://twitter.com/official_JemAl") else {break}
                UIApplication.shared.open(url)
            default:
                break
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                guard let url = URL(string: "https://github.com/r-spacex/SpaceX-API") else {break}
                UIApplication.shared.open(url)
            default:
                break
            }
        }
    }
}

// MARK: - views
extension SettingsTableView {
    // footer view
    func makeFooterView() -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))

        @TAMIC var footerLabel = UILabel()
        footerLabel.text = "Made by Jem with ❤️ ... for SpaceX 😄"
        footerLabel.textColor = .secondaryLabel
        footerLabel.textAlignment = .center
        footerLabel.font = .preferredFont(forTextStyle: .footnote)
        container.addSubview(footerLabel)
        let footerLabelWidthAnchor = footerLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -(.padding * 2))
        footerLabelWidthAnchor.priority = UILayoutPriority(750)

        @TAMIC var versionLabel = UILabel()
        versionLabel.text = "Version: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))"
        versionLabel.textColor = .secondaryLabel
        versionLabel.textAlignment = .center
        versionLabel.font = .preferredFont(forTextStyle: .footnote)
        container.addSubview(versionLabel)
        let versionLabelWidthAnchor = versionLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -(.padding * 2))
        versionLabelWidthAnchor.priority = UILayoutPriority(750)

        NSLayoutConstraint.activate([
            footerLabel.topAnchor.constraint(equalTo: container.topAnchor),
            footerLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: .padding),
            footerLabelWidthAnchor,
            versionLabel.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: .padding / 2),
            versionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: .padding),
            versionLabelWidthAnchor
        ])

        return container
    }

    // row label
    func makeLabelCell(icon: String, text: String, backgroundColor: UIColor = .tertiarySystemBackground) -> UITableViewCell {
        // make views
        let cell = UITableViewCell()
        @TAMIC var label = UILabel()
        @TAMIC var image = UIImageView()
        @TAMIC var imageContainer = UIView()
        @TAMIC var linkImage = UIImageView()

        // setup views
        // image
        imageContainer.backgroundColor = backgroundColor.withAlphaComponent(.opacityMedium)
        imageContainer.layer.cornerRadius = 8
        image.image = UIImage(systemName: icon)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        // label
        label.text = text
        label.font = .preferredFont(forTextStyle: .body)
        // link image
        linkImage.image = UIImage(systemName: "arrow.up.forward", withConfiguration: UIImage.SymbolConfiguration(pointSize: .fontBody, weight: .bold, scale: .large))

        // add views
        cell.addSubview(imageContainer)
        imageContainer.addSubview(image)
        cell.addSubview(label)
        cell.addSubview(linkImage)

        // constraints
        let imageHeightAnchor = imageContainer.heightAnchor.constraint(equalToConstant: 35)
        imageHeightAnchor.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: cell.topAnchor, constant: .padding / 2),
            imageContainer.leadingAnchor.constraint(equalTo: cell.layoutMarginsGuide.leadingAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 35),
            imageHeightAnchor,
            image.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: .padding),
            label.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            linkImage.trailingAnchor.constraint(equalTo: cell.layoutMarginsGuide.trailingAnchor),
            linkImage.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        ])

        // resize cell
        cell.makeCellResizable(with: imageContainer)

        return cell
    }
}

// MARK: - config
extension SettingsTableView {
    private func configure() {
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = UITableView.automaticDimension

        tableFooterView = makeFooterView()

        delegate = self
        dataSource = self
    }
}
