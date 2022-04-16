//

import Foundation

struct CoreModel: Decodable {
    let block: Int?
    let reuse_count: Int
    let rtls_attempts: Int
    let rtls_landings: Int
    let asds_attempts: Int
    let asds_landings: Int
    let last_update: String?
    let launches: [String]
    let serial: String
    let status: String
    let id: String
}
