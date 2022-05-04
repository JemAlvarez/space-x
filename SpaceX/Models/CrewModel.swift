//

import UIKit

struct CrewModel: Decodable {
    let name: String?
    let agency: String?
    let image: String?
    let wikipedia: String?
    let launches: [String]
    let status: String
    let id: String
}
