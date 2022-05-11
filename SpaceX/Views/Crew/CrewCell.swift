//

import UIKit
import JsHelper

class CrewCell: UICollectionViewCell {
    static let id = "CrewCell"

    // MARK: - data
    var name: String? {
        didSet {
            populateUI()
        }
    }
    var profileImageData: Data? {
        didSet {
            populateUI()
        }
    }

    // MARK: - views
    @TAMIC var nameLabel = UILabel()
    @TAMIC var moreInfoLabel = UILabel()
    @TAMIC var imageView = UIImageView()
    let placeholderImage = UIImage(
        systemName: "photo.fill",
        withConfiguration: UIImage.SymbolConfiguration(scale: .large)
    )?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)

    // MARK: - setup
    override init(frame: CGRect) {
        super.init(frame: frame)

        displayUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.contentMode = .center
        imageView.image = placeholderImage
    }

    // MARK: - funcs
    private func displayUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = .cornerRadius

        // add views
        addSubview(nameLabel)
        addSubview(imageView)
        addSubview(moreInfoLabel)

        // image view
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.image = placeholderImage

        // name
        nameLabel.text = "-"
        nameLabel.textAlignment = .center
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.numberOfLines = 2
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontSizeToFitWidth = true

        // more info button
        moreInfoLabel.text = "More Info"
        moreInfoLabel.textColor = .secondaryLabel
        moreInfoLabel.textAlignment = .center
        moreInfoLabel.font = .systemFont(ofSize: .fontSubheadline)

        // constraint views
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: .padding),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(.padding)),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            moreInfoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(.padding)),
            moreInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            moreInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(.padding)),
            moreInfoLabel.heightAnchor.constraint(equalToConstant: 20),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: moreInfoLabel.topAnchor, constant: -(.padding/2)),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(.padding))
        ])
    }

    private func populateUI() {
        nameLabel.text = name
        imageView.contentMode = .scaleAspectFill
        if let profileImageData = profileImageData {
            ImageCacher.downsample(with: profileImageData, to: CGSize(width: 170, height: 170)) { [weak self] img in
                DispatchQueue.main.async {
                    self?.imageView.image = img
                }
            }
        }
    }
}
