//

import Foundation

struct CapsuleModel: Decodable {
    let reuse_count: Int
    let water_landings: Int
    let last_update: String?
    let launches: [String]
    let serial: String
    let status: String
    let type: String
    let id: String
}
