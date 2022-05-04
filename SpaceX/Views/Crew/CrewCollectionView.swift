//

import UIKit

class CrewCollectionView: UICollectionView {
    var crew: [CrewModel]?
    var profileImages: [String: Data] = UserDefaults.standard.object(forKey: UserDefaults.Keys.cachedImages.rawValue) as? [String: Data] ?? [:] {
        didSet {
            UserDefaults.standard.set(profileImages, forKey: UserDefaults.Keys.cachedImages.rawValue)
        }
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 170, height: 250)
        layout.minimumLineSpacing = .padding
        layout.minimumInteritemSpacing = .padding
        config()
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}

// MARK: - delegate
extension CrewCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crew?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let crewCell = dequeueReusableCell(withReuseIdentifier: CrewCell.id, for: indexPath) as? CrewCell

        if let crewCell = crewCell, let crew = crew {
            let currentCrew = crew[indexPath.row]
            let profileImage = profileImages.first(where: { $0.key == currentCrew.image })

            if let profileImage = profileImage {
                // used cached image
                crewCell.profileImage = UIImage(data: profileImage.value)
            } else {
                // download image and cache
                DispatchQueue.global().async { [weak self] in
                    if let url = currentCrew.image {
                        let data = url.getURLData()

                        if let data = data {
                            self?.profileImages[url] = data

                            DispatchQueue.main.async {
                                crewCell.profileImage = UIImage(data: data)
                            }
                        }
                    }
                }
            }

            crewCell.name = currentCrew.name

            return crewCell
        }

        return UICollectionViewCell()
    }
}

// MARK: - config
extension CrewCollectionView {
    private func config() {
        register(CrewCell.self, forCellWithReuseIdentifier: CrewCell.id)
        dataSource = self
        contentInset = UIEdgeInsets(top: 0, left: .padding, bottom: .padding * 2, right: .padding)
    }
}
