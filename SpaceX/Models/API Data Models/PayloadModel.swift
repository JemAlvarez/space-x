//

import Foundation

struct PayloadModel: Decodable {
    let dragon: Dragon
    let name: String?
    let type: String?
    let reused: Bool
    let launch: String?
    let customers: [String]
    let norad_ids: [Int]
    let nationalities: [String]
    let manufacturers: [String]
    let mass_kg: Double?
    let mass_lbs: Double?
    let orbit: String?
    let reference_system: String?
    let regime: String?
    let longitude: Double?
    let semi_major_axis_km: Double?
    let eccentricity: Double?
    let periapsis_km: Double?
    let apoapsis_km: Double?
    let inclination_deg: Double?
    let period_min: Double?
    let lifespan_years: Double?
    let epoch: String?
    let mean_motion: Double?
    let raan: Double?
    let arg_of_pericenter: Double?
    let mean_anomaly: Double?
    let id: String?

    struct Dragon: Decodable {
        let land_landing: Bool?
        let water_landing: Bool?
        let manifest: String?
        let flight_time_sec: Double?
        let mass_returned_lbs: Double?
        let mass_returned_kg: Double?
        let capsule: String?
    }
}
