//

import UIKit
import JsHelper

class CrewInfoVC: UIViewController {
    // MARK: - data
    var crew: CrewModel
    let imageSize: CGSize = CGSize(width: 240, height: 240)

    // MARK: - views
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = UIStackView.spacingUseSystem
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    // MARK: - setup
    init(crew: CrewModel) {
        self.crew = crew
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        displayUI()
    }
}

// MARK: - ui
extension CrewInfoVC {
    private func displayUI() {
        scrollView()
        image()
        addLine(title: "Agency", value: crew.agency)
        addLine(title: "Status", value: crew.status.capitalized)
        wikipediaLink()
        launches()
    }

    private func scrollView() {
        @TAMIC var scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.addConstraints(equalTo: view)
        scrollView.contentInset = UIEdgeInsets(top: .padding, left: .padding, bottom: .padding, right: -(.padding))
        stackView.addConstraints(equalTo: scrollView)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(.padding * 2)).isActive = true
    }

    private func image() {
        @TAMIC var container = UIView()
        @TAMIC var iv = UIImageView()
        iv.contentMode = .center
        iv.image = UIImage(
            systemName: "photo.fill",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = imageSize.width / 2
        ImageCacher.shared.getCachedImageData(imageUrl: crew.image) { imageData in
            ImageCacher.downsample(with: imageData, to: self.imageSize) { img in
                DispatchQueue.main.async {
                    iv.contentMode = .scaleAspectFill
                    iv.image = img
                }
            }
        }
        container.addSubview(iv)
        stackView.addArrangedSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: imageSize.height),
            iv.widthAnchor.constraint(equalToConstant: imageSize.width),
            iv.heightAnchor.constraint(equalToConstant: imageSize.height),
            iv.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
    }

    private func addLine(title: String, value: String?) {
        let label = UILabel()
        label.text = "\(title): \(value ?? "-")"
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        stackView.addArrangedSubview(label)
    }

    private func wikipediaLink() {
        let btn = UILinkButton()
        btn.setTitle("Wikipedia", for: .normal)
        btn.link = crew.wikipedia ?? ""
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.contentHorizontalAlignment = .leading
        btn.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        btn.titleLabel?.adjustsFontForContentSizeCategory = true
        stackView.addArrangedSubview(btn)
    }

    private func launches() {
        Task.init {
            let launches = await getLaunches()

            if !launches.isEmpty {
                // title
                let sectionTitle = UILabel()
                sectionTitle.text = "Launches"
                sectionTitle.font = .preferredFont(forTextStyle: .title1)
                sectionTitle.adjustsFontForContentSizeCategory = true
                sectionTitle.textAlignment = .left
                stackView.addArrangedSubview(sectionTitle)

                // launches container
                @TAMIC var container = UIStackView()
                container.axis = .vertical
                container.spacing = .padding / 2
                container.backgroundColor = .secondarySystemBackground
                container.layer.cornerRadius = .cornerRadius
                container.layoutMargins = UIEdgeInsets(top: .padding / 2, left: .padding / 2, bottom: .padding / 2, right: .padding / 2)
                container.isLayoutMarginsRelativeArrangement = true

                // launch
                for launch in launches {
                    let launchLine = makeLaunchLine(launch)
                    container.addArrangedSubview(launchLine)
                }

                stackView.addArrangedSubview(container)
            }
        }
    }

    private func makeLaunchLine(_ launch: LaunchModel) -> UIView {
        let tapGesture = NavigateTapGesture(target: self, action: #selector(navigateToLaunch(_:)))
        tapGesture.viewController = LaunchInfoVC(launch: launch)

        let container = UIView()
        @TAMIC var iv = UIImageView()
        @TAMIC var name = UILabel()
        @TAMIC var time = UILabel()
        @TAMIC var navigationIndicator = UIImageView()

        container.addGestureRecognizer(tapGesture)
        container.addSubview(iv)
        container.addSubview(name)
        container.addSubview(time)
        container.addSubview(navigationIndicator)

        // container
        container.topAnchor.constraint(equalTo: name.topAnchor).isActive = true

        // image view
        iv.contentMode = .center
        iv.image = UIImage(
            systemName: "photo.fill",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
        iv.clipsToBounds = true
        ImageCacher.shared.getCachedImageData(imageUrl: launch.links.patch.small) { imageData in
            DispatchQueue.main.async {
                iv.contentMode = .scaleAspectFill
                iv.image = UIImage(data: imageData)
            }
        }
        NSLayoutConstraint.activate([
            iv.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            iv.widthAnchor.constraint(equalToConstant: 25),
            iv.heightAnchor.constraint(equalToConstant: 25),
            iv.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        // name
        name.text = launch.name
        name.font = .preferredFont(forTextStyle: .headline)
        name.adjustsFontSizeToFitWidth = true
        name.adjustsFontForContentSizeCategory = true
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: iv.trailingAnchor, constant: .padding),
            name.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30)
        ])

        // time
        time.text = Date(timeIntervalSince1970: TimeInterval(launch.date_unix)).getString(with: .commaWithWeekday)
        time.textColor = .secondaryLabel
        time.font = .preferredFont(forTextStyle: .subheadline)
        time.adjustsFontSizeToFitWidth = true
        time.adjustsFontForContentSizeCategory = true
        NSLayoutConstraint.activate([
            time.leadingAnchor.constraint(equalTo: iv.trailingAnchor, constant: .padding),
            time.topAnchor.constraint(equalTo: name.bottomAnchor),
            time.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30)
        ])

        // navigation indicator image
        navigationIndicator.image = UIImage(systemName: "chevron.right")?.withTintColor(UIColor.secondaryLabel)
        navigationIndicator.contentMode = .center
        NSLayoutConstraint.activate([
            navigationIndicator.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            navigationIndicator.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            navigationIndicator.heightAnchor.constraint(equalToConstant: 20),
            navigationIndicator.widthAnchor.constraint(equalToConstant: 20)
        ])

        container.bottomAnchor.constraint(equalTo: time.bottomAnchor).isActive = true

        return container
    }
}

// MARK: - config
extension CrewInfoVC {
    private func getLaunches() async -> [LaunchModel] {
        // get launches
        var launches: [LaunchModel] = []

        for launchId in crew.launches {
            let launch = await APIModel.shared.fetchLaunches(with: launchId)
            if let launch = launch {
                launches.append(launch)
            }
        }

        return launches
    }

    private func config() {
        view.backgroundColor = .systemBackground
        navigationItem.title = crew.name
    }

    @objc func navigateToLaunch(_ sender: NavigateTapGesture) {
        navigationController?.pushViewController(sender.viewController, animated: true)
    }
}
