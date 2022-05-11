//

import Foundation

struct LandPadModel: Decodable {
    let name: String?
    let full_name: String?
    let status: String
    let type: String?
    let locality: String?
    let region: String?
    let latitude: Double?
    let longitude: Double?
    let landing_attempts: Int
    let landing_successes: Int
    let wikipedia: String?
    let details: String?
    let launches: [String]
    let id: String
}
