//

import Foundation

struct ShipModel: Decodable {
    let legacy_id: String?
    let model: String?
    let type: String?
    let roles: [String]
    let imo: Int?
    let mmsi: Int?
    let abs: Int?
    let `class`: Int?
    let mass_kg: Double?
    let mass_lbs: Double?
    let year_built: Int?
    let home_port: String?
    let status: String?
    let speed_kn: Double?
    let course_deg: Double?
    let latitude: Double?
    let longitude: Double?
    let last_ais_update: String?
    let link: String?
    let image: String?
    let launches: [String]
    let name: String
    let active: Bool
    let id: String
}
