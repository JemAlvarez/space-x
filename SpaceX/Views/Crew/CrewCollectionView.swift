//

import UIKit

class CrewCollectionView: UICollectionView {
    var navigationDelegate: UICollectionViewNavigation?

    var crew: [CrewModel]?

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 170, height: 250)
        layout.minimumLineSpacing = .padding
        layout.minimumInteritemSpacing = .padding
        config()
    }

    deinit {
        print("de init")
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}

// MARK: - delegate
extension CrewCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crew?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let crew = crew {
            navigationDelegate?.pushViewController(with: CrewInfoVC(crew: crew[indexPath.row]))
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let crewCell = dequeueReusableCell(withReuseIdentifier: CrewCell.id, for: indexPath) as? CrewCell
        crewCell?.layer.shouldRasterize = true
        crewCell?.layer.rasterizationScale = UIScreen.main.scale

        if let crewCell = crewCell, let crew = crew {
            let currentCrew = crew[indexPath.row]

            ImageCacher.shared.getCachedImageData(imageUrl: currentCrew.image) { imageData in
                crewCell.profileImageData = imageData
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
        delegate = self
        contentInset = UIEdgeInsets(top: 0, left: .padding, bottom: .padding * 2, right: .padding)
    }
}
