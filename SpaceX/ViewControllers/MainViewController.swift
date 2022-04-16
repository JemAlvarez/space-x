//

import UIKit
import JsHelper

class MainViewController: UIViewController {
    var currentID: String = ""

    @TAMIC var label: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        return label
    }()

    @TAMIC var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Copy", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        view.addSubview(image)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: label.bottomAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: image.bottomAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        APIModel.shared.fetch(for: .rockets) { (rockets: [RocketModel]) in
            if !rockets.isEmpty {
                self.label.text = rockets[0].name
                self.currentID = rockets[0].id

                if !rockets[0].flickr_images.isEmpty {
                    guard let data = try? Data(contentsOf: URL(string: rockets[0].flickr_images[0])!) else {return}
                    guard let uiImage = UIImage(data: data) else {return}
                    DispatchQueue.main.async {
                        self.image.image = uiImage
                    }
                }
            }
        }
    }

    @objc func pressed() {
        print(currentID)
        UIPasteboard.general.string = currentID
    }
}
