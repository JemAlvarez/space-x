//

import UIKit

extension String {
    func getURLData() -> Data? {
        if let url = URL(string: self) {
            return try? Data(contentsOf: url)
        }
        return nil
    }
}
