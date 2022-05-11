//

import Foundation

struct RoadsterModel: Decodable {
    let flickr_images: [String]
    let name: String
    let launch_date_utc: String
    let launch_date_unix: Int
    let launch_mass_kg: Double
    let launch_mass_lbs: Double
    let norad_id: Int
    let epoch_jd: Double
    let orbit_type: String
    let apoapsis_au: Double
    let periapsis_au: Double
    let semi_major_axis_au: Double
    let eccentricity: Double
    let inclination: Double
    let longitude: Double
    let periapsis_arg: Double
    let period_days: Double
    let speed_kph: Double
    let speed_mph: Double
    let earth_distance_km: Double
    let earth_distance_mi: Double
    let mars_distance_km: Double
    let mars_distance_mi: Double
    let wikipedia: String
    let video: String
    let details: String
    let id: String
}
