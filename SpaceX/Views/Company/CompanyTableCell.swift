//

import UIKit
import JsHelper

class CompanyTableCell: UITableViewCell {

    static let id = "CompanyTableCell"

    var companyData: CompanyModel? {
        didSet {
            populateData()
        }
    }

    // MARK: - view
    @TAMIC var logoImageView = UIImageView()
    @TAMIC var summaryLabel = UILabel()
    @TAMIC var foundedLabel = UILabel()
    @TAMIC var valuationLabel = UILabel()
    @TAMIC var employeesLabel = UILabel()
    @TAMIC var vehiclesLabel = UILabel()
    @TAMIC var launchSitesLabel = UILabel()
    @TAMIC var testSitesLabel = UILabel()
    @TAMIC var headquartersLabel = UILabel()
    @TAMIC var founderLabel = UILabel()
    @TAMIC var ceoLabel = UILabel()
    @TAMIC var ctoLabel = UILabel()
    @TAMIC var ctoPropLabel = UILabel()
    @TAMIC var cooLabel = UILabel()

    // MARK: - setup
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureCell()
        displayUI()
        makeCellResizable(with: cooLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ui
extension CompanyTableCell {
    // display all ui
    private func displayUI() {
        // SpaceX Logo
        logoImage()
        // Summary
        summary()
        // Info
        info()
        // People
        people()
        // Links
            // Website
            // Twitter
            // Elon Twitter
            // Flickr
    }

    // MARK: - logo
    private func logoImage() {
        let logoImage = UIImage(named: "logo")
        addSubview(logoImageView)

        // set image
        logoImageView.image = logoImage

        // constraints
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }

    // MARK: - summary
    private func summary() {
        // Summary
        addSubview(summaryLabel)
        summaryLabel.text = "-"
        summaryLabel.numberOfLines = 0
        summaryLabel.font = .systemFont(ofSize: .fontBody, weight: .light)

        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: .padding),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding * 2),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(.padding * 2))
        ])
    }

    // MARK: - info
    private func info() {
        // Background view
        @TAMIC var backgroundView = makeBackground()
        addSubview(backgroundView)
        // Title
        @TAMIC var titleLabel = makeTitle("Info")
        // Founded
        addLabel(foundedLabel, parentView: backgroundView)
        // Valuation
        addLabel(valuationLabel, parentView: backgroundView)
        // Employees
        addLabel(employeesLabel, parentView: backgroundView)
        // Vehicles
        addLabel(vehiclesLabel, parentView: backgroundView)
        // Launch sites
        addLabel(launchSitesLabel, parentView: backgroundView)
        // Test sites
        addLabel(testSitesLabel, parentView: backgroundView)
        // Headquarters
        addLabel(headquartersLabel, parentView: backgroundView)
        headquartersLabel.numberOfLines = 2

        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: .padding),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: .padding),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -(.padding)),
            foundedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .padding),
            valuationLabel.topAnchor.constraint(equalTo: foundedLabel.bottomAnchor, constant: .padding),
            employeesLabel.topAnchor.constraint(equalTo: valuationLabel.bottomAnchor, constant: .padding),
            vehiclesLabel.topAnchor.constraint(equalTo: employeesLabel.bottomAnchor, constant: .padding),
            launchSitesLabel.topAnchor.constraint(equalTo: vehiclesLabel.bottomAnchor, constant: .padding),
            testSitesLabel.topAnchor.constraint(equalTo: launchSitesLabel.bottomAnchor, constant: .padding),
            headquartersLabel.topAnchor.constraint(equalTo: testSitesLabel.bottomAnchor, constant: .padding),

            backgroundView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: .padding),
            backgroundView.bottomAnchor.constraint(equalTo: headquartersLabel.bottomAnchor, constant: .padding)
        ])
    }

    // MARK: - people
    private func people() {
        // Background view
        @TAMIC var backgroundView = makeBackground()
        addSubview(backgroundView)
        // title
        @TAMIC var titleLabel = makeTitle("People")
        // Founder
        addLabel(founderLabel, parentView: backgroundView)
        // CEO
        addLabel(ceoLabel, parentView: backgroundView)
        // CTO
        addLabel(ctoLabel, parentView: backgroundView)
        // CTO_Propulsion
        addLabel(ctoPropLabel, parentView: backgroundView)
        // COO
        addLabel(cooLabel, parentView: backgroundView)

        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: .padding),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: .padding),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -(.padding)),
            founderLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .padding),
            ceoLabel.topAnchor.constraint(equalTo: founderLabel.bottomAnchor, constant: .padding),
            ctoLabel.topAnchor.constraint(equalTo: ceoLabel.bottomAnchor, constant: .padding),
            ctoPropLabel.topAnchor.constraint(equalTo: ctoLabel.bottomAnchor, constant: .padding),
            cooLabel.topAnchor.constraint(equalTo: ctoPropLabel.bottomAnchor, constant: .padding),

            backgroundView.topAnchor.constraint(equalTo: headquartersLabel.bottomAnchor, constant: .padding * 2),
            backgroundView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: cooLabel.bottomAnchor, constant: .padding)
        ])
    }

    // MARK: - helper funcs
    // setup label by adding to view, settings text, n lines, and width anchors
    private func addLabel(_ label: UILabel, parentView: UIView) {
        addSubview(label)
        label.text = "-"
        label.numberOfLines = 1

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: .padding),
            label.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -(.padding))
        ])
    }

    private func makeTitle(_ title: String) -> UILabel {
        let titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: .fontTitle3, weight: .bold)
        titleLabel.textAlignment = .center
        return titleLabel
    }

    private func makeBackground() -> UIView {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .secondarySystemBackground
        backgroundView.layer.cornerRadius = .cornerRadius
        return backgroundView
    }

    // generate attributed string with icon
    private func makeLabel(title: String, text: String, icon: String) -> NSAttributedString {
        let fullString = NSMutableAttributedString()
        fullString.append(NSAttributedString(string: icon))
        fullString.append(NSAttributedString(string: " \(title): ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: .fontBody, weight: .semibold)]))
        fullString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]))

        return fullString
    }
}

// MARK: - config
extension CompanyTableCell {
    private func configureCell() {
        selectionStyle = .none
    }

    private func makeCellResizable(with lastItem: UIView) {
        NSLayoutConstraint.activate([
            // make cell resizable
            lastItem.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }

    func setupData(with companyData: CompanyModel) {
        self.companyData = companyData
    }

    private func populateData() {
        if let companyData = self.companyData {
            // Summary
            self.summaryLabel.text = companyData.summary
            // Info
            self.foundedLabel.attributedText = makeLabel(title: "Founded", text: "\(companyData.founded)", icon: "📅")
            self.valuationLabel.attributedText = makeLabel(title: "Valuation", text: "$\(companyData.valuation.formatMoney())", icon: "💰")
            self.employeesLabel.attributedText = makeLabel(title: "Employees", text: "\(companyData.employees)", icon: "🧑‍🔧")
            self.vehiclesLabel.attributedText = makeLabel(title: "Vehicles", text: "\(companyData.vehicles)", icon: "🚀")
            self.launchSitesLabel.attributedText = makeLabel(title: "Launch Sites", text: "\(companyData.launch_sites)", icon: "🏗")
            self.testSitesLabel.attributedText = makeLabel(title: "Test Sites", text: "\(companyData.test_sites)", icon: "🏗")
            self.headquartersLabel.attributedText = makeLabel(title: "Location", text: "\(companyData.headquarters.address), \(companyData.headquarters.city), \(companyData.headquarters.state)", icon: "🏢")
            // People
            self.founderLabel.attributedText = makeLabel(title: "Founder", text: companyData.founder, icon: "👨‍💻")
            self.ceoLabel.attributedText = makeLabel(title: "CEO", text: companyData.ceo, icon: "👨‍💻")
            self.ctoLabel.attributedText = makeLabel(title: "CTO", text: companyData.cto, icon: "👨‍💻")
            self.ctoPropLabel.attributedText = makeLabel(title: "CTO Propulsion", text: companyData.cto_propulsion, icon: "👨‍💻")
            self.cooLabel.attributedText = makeLabel(title: "COO", text: companyData.coo, icon: "👨‍💻")
            // Links
        }
    }
}
