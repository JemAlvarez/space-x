//

import UIKit
import JsHelper

class HistoryTableCell: UITableViewCell {

    static let id = "HistoryTableCell"

    var historyData: HistoryModel? {
        didSet {
            populateData()
        }
    }

    private var linkButtonWidth: CGFloat = 35

    // MARK: - views
    @TAMIC var titleLabel = UILabel()
    @TAMIC var dateUTCLabel = UILabel()
    @TAMIC var dateLabel = UILabel()
    @TAMIC var detailsLabel = UILabel()
    @TAMIC var articleLinkButton = UILinkButton()

    // MARK: - setup
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureCell()
        displayUI()
        makeCellResizable(with: dateUTCLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}

// MARK: - views
extension HistoryTableCell {
    private func displayUI() {
        // title
        addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .systemFont(ofSize: .fontBody, weight: .bold))
        // details
        addSubview(detailsLabel)
        detailsLabel.numberOfLines = 0
        detailsLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .systemFont(ofSize: .fontBody, weight: .light))
        // dates
        addSubview(dateLabel)
        dateLabel.numberOfLines = 0
        dateLabel.textColor = .secondaryLabel
        addSubview(dateUTCLabel)
        dateUTCLabel.numberOfLines = 0
        dateUTCLabel.textColor = .secondaryLabel
        // link
        addSubview(articleLinkButton)
        articleLinkButton.setTitle("🔗", for: .normal)
        articleLinkButton.backgroundColor = .systemBlue
        articleLinkButton.layer.cornerRadius = linkButtonWidth / 2
        articleLinkButton.titleLabel?.font = .preferredFont(forTextStyle: .body)

        NSLayoutConstraint.activate([
            // title
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: .padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(linkButtonWidth + .padding * 2)),
            // details
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .padding / 2),
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(linkButtonWidth + .padding * 2)),
            // dates
            dateLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: .padding / 2),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(linkButtonWidth + .padding * 2)),
            dateUTCLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: .padding / 2),
            dateUTCLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            dateUTCLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(linkButtonWidth + .padding * 2)),
            // link
            articleLinkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(.padding)),
            articleLinkButton.widthAnchor.constraint(equalToConstant: linkButtonWidth),
            articleLinkButton.heightAnchor.constraint(equalToConstant: linkButtonWidth),
            articleLinkButton.topAnchor.constraint(equalTo: topAnchor, constant: .padding)
        ])
    }
}

// MARK: - config
extension HistoryTableCell {
    private func configureCell() {
        selectionStyle = .none
        contentView.isUserInteractionEnabled = true
    }

    private func populateData() {
        if let historyData = historyData {
            self.titleLabel.text = historyData.title ?? "-"
            self.detailsLabel.text = historyData.details ?? "-"

            let dateString = NSMutableAttributedString()
            dateString.append(NSAttributedString(string: "Date: ", attributes: [.font: UIFontMetrics(forTextStyle: .footnote).scaledFont(for: UIFont.systemFont(ofSize: .fontFootnote, weight: .bold))]))
            if let unix = historyData.event_date_unix {
                let date = Date(timeIntervalSince1970: TimeInterval(unix)).getString(with: "MMM d, yyyy h:mm a")
                dateString.append(NSAttributedString(string: date, attributes: [.font: UIFontMetrics(forTextStyle: .footnote).scaledFont(for: UIFont.systemFont(ofSize: .fontFootnote, weight: .light))]))
            } else {
                dateString.append(NSAttributedString(string: "-", attributes: [.font: UIFontMetrics(forTextStyle: .footnote).scaledFont(for: UIFont.systemFont(ofSize: .fontFootnote, weight: .light))]))
            }
            self.dateLabel.attributedText = dateString

            let utcDateString = NSMutableAttributedString()
            utcDateString.append(NSAttributedString(string: "UTC Date: ", attributes: [.font: UIFontMetrics(forTextStyle: .footnote).scaledFont(for: UIFont.systemFont(ofSize: .fontFootnote, weight: .bold))]))
            utcDateString.append(NSAttributedString(string: historyData.event_date_utc ?? "-", attributes: [.font: UIFontMetrics(forTextStyle: .footnote).scaledFont(for: UIFont.systemFont(ofSize: .fontFootnote, weight: .light))]))
            self.dateUTCLabel.attributedText = utcDateString

            self.articleLinkButton.link = historyData.links.article ?? ""
            self.articleLinkButton.layer.opacity = historyData.links.article == nil ? .opacityLow : 1
        }
    }
}
