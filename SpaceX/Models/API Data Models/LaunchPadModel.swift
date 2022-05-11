//

import Foundation

struct LaunchPadModel: Decodable {
    let name: String?
    let full_name: String?
    let locality: String?
    let region: String?
    let timezone: String
    let latitude: Double?
    let longitude: Double?
    let launch_attempts: Int
    let launch_successes: Int
    let rockets: [String]
    let launches: [String]
    let status: String
    let id: String
}
