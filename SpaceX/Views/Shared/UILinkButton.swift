//

import UIKit

class UILinkButton: UIButton {
    var link: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(openLink), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }

    @objc func openLink() {
        guard let url = URL(string: link) else {return}
        UIApplication.shared.open(url)
    }
}
